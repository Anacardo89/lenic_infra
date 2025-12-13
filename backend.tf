terraform {
  backend "s3" {
    bucket         = "lenic-dev-terraform-state"
    key            = "dev/terraform.tfstate"
    region         = "eu-west-3"
    dynamodb_table = "lenic-env-terraform-lock"
    encrypt        = true
  }
}
