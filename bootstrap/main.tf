########################################################
# BOOTSTRAP LAYER
# This layer creates foundational resources required
# before CI/CD can run:
# - GitHub OIDC provider
# - GitHub IAM deploy role
# - S3 backend bucket (Terraform state)
#
# This stack runs locally only (one-time setup).
########################################################

terraform {
  # Define required provider versions
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

# AWS Provider Configuration
# This uses your local AWS credentials.
provider "aws" {
  region = "ap-south-1"
}
