# Changelog

### [v0.1.0] — 2025-07-05
#### Added
- Implemented SSH key pair integration for secure remote access to EC2 
- Created secure connectivity for EC2 
- Verified minimal infrastructure deployment enabling backend
- Prepared outputs for easy retrieval of EC2 connection details 

### [v0.0.2] - 2025-07-05
#### Added
- Network configuration: VPC, subnets, and route tables
- Security group with SSH, HTTP, and HTTPS ingress rules

### [v0.0.1] - 2025-07-05
#### Added
- Initial Terraform project structure
- CI/CD pipeline with GitHub Actions:
  - `plan` workflow on `dev` branch push
  - `apply` workflow on release publish
- Secrets management using GitHub Actions Secrets