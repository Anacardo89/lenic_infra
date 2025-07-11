#!/bin/bash

set -euo pipefail

echo "Initializing Terraform..."
cd "$(dirname "${BASH_SOURCE[0]}")/.."
terraform init

echo "Destroying infrastructure using tfvars..."
terraform destroy -auto-approve
