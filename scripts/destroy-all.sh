#!/bin/bash
set -euo pipefail

# === Step 1: Get all tagged resources ===
echo "Fetching all tagged resources..."
aws resourcegroupstaggingapi get-resources --query 'ResourceTagMappingList[].ResourceARN' --output text | tr '\t' '\n' > resources.txt

if [[ ! -s resources.txt ]]; then
  echo "No tagged resources found. Nothing to delete."
else
  while read -r arn; do
    echo "Processing $arn"

    if [[ $arn == arn:aws:ec2:* ]]; then
      resource_type=$(echo "$arn" | cut -d: -f6 | cut -d/ -f1)
      resource_id=$(echo "$arn" | cut -d/ -f2)

      case "$resource_type" in
        instance)
          echo "Terminating EC2 instance $resource_id"
          aws ec2 terminate-instances --instance-ids "$resource_id"
          ;;

        internet-gateway)
          echo "Detaching and deleting internet gateway $resource_id"
          vpcs=$(aws ec2 describe-internet-gateways --internet-gateway-ids "$resource_id" --query 'InternetGateways[0].Attachments[].VpcId' --output text | tr '\t' '\n')
          for vpc in $vpcs; do
            echo "Detaching IGW $resource_id from VPC $vpc"
            aws ec2 detach-internet-gateway --internet-gateway-id "$resource_id" --vpc-id "$vpc"
          done
          aws ec2 delete-internet-gateway --internet-gateway-id "$resource_id"
          ;;

        subnet)
          echo "Deleting subnet $resource_id"
          aws ec2 delete-subnet --subnet-id "$resource_id"
          ;;

        route-table)
          echo "Handling route table $resource_id"
          aws ec2 describe-route-tables --route-table-ids "$resource_id" \
            --query 'RouteTables[0].Associations[?Main!=`true`].RouteTableAssociationId' \
            --output text | tr '\t' '\n' > assoc_ids.txt
          if [[ -s assoc_ids.txt ]]; then
            while read -r assoc_id; do
              echo "Disassociating route table association $assoc_id"
              aws ec2 disassociate-route-table --association-id "$assoc_id"
            done < assoc_ids.txt
            rm -f assoc_ids.txt
          fi
          echo "Deleting route table $resource_id"
          aws ec2 delete-route-table --route-table-id "$resource_id" || echo "Warning: Could not delete route table $resource_id"
          ;;

        security-group)
          echo "Deleting security group $resource_id"
          aws ec2 delete-security-group --group-id "$resource_id"
          ;;

        vpc)
          echo "Deleting VPC $resource_id"
          aws ec2 delete-vpc --vpc-id "$resource_id" || echo "Warning: Could not delete VPC $resource_id"
          ;;

        *)
          echo "Unknown EC2 resource type $resource_type for ARN $arn"
          ;;
      esac

    elif [[ $arn == arn:aws:rds:* ]]; then
      resource_id=$(echo "$arn" | rev | cut -d: -f1 | rev)
      echo "Deleting RDS instance $resource_id"
      aws rds delete-db-instance --db-instance-identifier "$resource_id" --skip-final-snapshot

    elif [[ $arn == arn:aws:s3:::* ]]; then
      bucket_name=$(echo "$arn" | cut -d: -f6)
      echo "Deleting S3 bucket $bucket_name"
      aws s3 rb "s3://$bucket_name" --force

    else
      echo "Unknown or unsupported resource ARN: $arn"
    fi
  done < resources.txt

  rm -f resources.txt
fi

# === Step 2: Orphaned resources (non-tagged) ===

# Snapshots
echo "Checking for snapshots..."
aws ec2 describe-snapshots --owner-ids self --query 'Snapshots[].SnapshotId' --output text | tr '\t' '\n' > snapshots.txt
if [[ -s snapshots.txt ]]; then
  while read -r snap; do
    echo "Deleting snapshot $snap"
    aws ec2 delete-snapshot --snapshot-id "$snap"
  done < snapshots.txt
  rm -f snapshots.txt
else
  echo "✅ No snapshots to delete."
fi

# Volumes
echo "Checking for EBS volumes..."
aws ec2 describe-volumes --query 'Volumes[].VolumeId' --output text | tr '\t' '\n' > volumes.txt
if [[ -s volumes.txt ]]; then
  while read -r vol; do
    echo "Deleting volume $vol"
    aws ec2 delete-volume --volume-id "$vol"
  done < volumes.txt
  rm -f volumes.txt
else
  echo "✅ No EBS volumes to delete."
fi

# Elastic IPs
echo "Checking for Elastic IPs..."
aws ec2 describe-addresses --query 'Addresses[].AllocationId' --output text | tr '\t' '\n' > eips.txt
if [[ -s eips.txt ]]; then
  while read -r eip; do
    echo "Releasing Elastic IP $eip"
    aws ec2 release-address --allocation-id "$eip"
  done < eips.txt
  rm -f eips.txt
else
  echo "✅ No Elastic IPs to delete."
fi

# Network Interfaces
echo "Checking for network interfaces..."
aws ec2 describe-network-interfaces --query 'NetworkInterfaces[].NetworkInterfaceId' --output text | tr '\t' '\n' > enis.txt
if [[ -s enis.txt ]]; then
  while read -r eni; do
    echo "Deleting network interface $eni"
    aws ec2 delete-network-interface --network-interface-id "$eni"
  done < enis.txt
  rm -f enis.txt
else
  echo "✅ No network interfaces to delete."
fi

# Secrets Manager
echo "Checking for Secrets Manager secrets..."
aws secretsmanager list-secrets --query 'SecretList[].Name' --output text | tr '\t' '\n' > secrets.txt
if [[ -s secrets.txt ]]; then
  while read -r secret; do
    echo "Deleting secret $secret"
    aws secretsmanager delete-secret --secret-id "$secret" --force-delete-without-recovery
  done < secrets.txt
  rm -f secrets.txt
else
  echo "✅ No secrets to delete."
fi

# KMS Keys (scheduled deletion only)
echo "Checking for KMS keys..."
aws kms list-keys --query 'Keys[].KeyId' --output text | tr '\t' '\n' > keys.txt
if [[ -s keys.txt ]]; then
  while read -r key; do
    state=$(aws kms describe-key --key-id "$key" --query 'KeyMetadata.KeyState' --output text 2>/dev/null || echo "Unavailable")
    if [[ "$state" == "PendingDeletion" ]]; then
      echo "KMS key $key already scheduled for deletion."
    elif [[ "$state" == "Enabled" ]]; then
      echo "Scheduling deletion for KMS key $key"
      aws kms schedule-key-deletion --key-id "$key" --pending-window-in-days 7
    else
      echo "Skipping key $key (state: $state)"
    fi
  done
  rm -f keys.txt
else
  echo "✅ No KMS keys found."
fi

# === Final Verification ===
echo ""
echo "====== Final Check ======"

echo "Remaining tagged resources:"
aws resourcegroupstaggingapi get-resources --query 'ResourceTagMappingList[].ResourceARN' --output text || echo "✅ No tagged resources remain."

echo ""
echo "Remaining snapshots:"
aws ec2 describe-snapshots --owner-ids self --query 'Snapshots[].SnapshotId' --output text || echo "✅ No snapshots remain."

echo ""
echo "Remaining volumes:"
aws ec2 describe-volumes --query 'Volumes[].VolumeId' --output text || echo "✅ No volumes remain."

echo ""
echo "Remaining Elastic IPs:"
aws ec2 describe-addresses --query 'Addresses[].AllocationId' --output text || echo "✅ No Elastic IPs remain."

echo ""
echo "Remaining network interfaces:"
aws ec2 describe-network-interfaces --query 'NetworkInterfaces[].NetworkInterfaceId' --output text || echo "✅ No network interfaces remain."

echo ""
echo "Remaining secrets:"
aws secretsmanager list-secrets --query 'SecretList[].Name' --output text || echo "✅ No secrets remain."

echo ""
echo "KMS keys (note: may still exist if not yet deleted):"
aws kms list-keys --query 'Keys[].KeyId' --output text || echo "✅ No KMS keys remain."

echo ""
echo "✅ Full cleanup completed."
