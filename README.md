# Lenic - Infrastructure

This repository contains the **infrastructure code** for deploying and managing the backend systems of Lenic, the social network.

All infrastructure is managed via [Terraform](https://www.terraform.io/) and deployed using **CI/CD pipelines** on GitHub Actions.

---

## 📦 Structure

- `main.tf`            – Entry point for Terraform config
- `variables.tf`       – Input variable definitions
- `network.tf`         – VPC, subnets and Gateway
- `routing.tf`         – Routing configuration
- `security.tf`        – Security group definitions (firewall rules)
- `ec2.tf`             – EC2 instance
- `ssh.tf`             – SSH key pair import and related setup
- `outputs.tf`         – Outputs for EC2 and RDS
- `terraform.tfvars`   – Project/environment-specific variable values (not committed, redeclared in workflows)
- `.github/workflows/` – CI/CD pipelines for plan and apply stages

---

## 🚀 CI/CD Pipelines

### Plan on `dev` branch push
- Runs `terraform init` and `terraform plan`
- Validates changes without applying them

### Apply on Release
- Runs `terraform apply` when a new release is published (e.g. `v0.0.1`)
- Pulls secrets from GitHub Actions secrets
- Input variables passed at runtime

---

## 🔐 Secrets Management

Secrets like AWS credentials are not stored in the repo. They are managed through:

- `terraform.tfvars` – For non-sensitive configuration
- GitHub Actions Secrets – For sensitive data (e.g. AWS Access)

---

## 📜 Changelog

See [CHANGELOG.md](./CHANGELOG.md) for a history of changes and versions.

---

## 🛠 Requirements

- Terraform v1.12+
- AWS CLI configured (for local use)
- GitHub Actions enabled on your fork (for CI/CD)

---

## 🧭 Roadmap

- [x] Set up Terraform and basic pipeline
  - [x] Write `main.tf`, `variables.tf`
  - [x] Add GitHub Actions workflows for `dev` and `release`
- [ ] Provision basic AWS resources
  - [x] Create VPC, subnets, gateway, routing and security group
  - [x] Launch EC2 instance
  - [ ] Set up S3 bucket for assets
- [ ] Deploy backend services
- [ ] Enable monitoring/logging
- [ ] Set up DNS and CDN for frontend

---

## 📄 License

This project is for portfolio purposes. No license is currently specified.