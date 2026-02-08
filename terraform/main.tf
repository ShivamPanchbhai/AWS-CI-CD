############################################
# Terraform core configuration
############################################
terraform {

  # Define required providers and versions
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }

  # Remote backend for Terraform state
  # State is stored centrally in S3
  backend "s3" {
    bucket = "shivam-terraform-state-3069"
    key    = "ec2/terraform.tfstate"
    region = "ap-south-1"
  }
}

############################################
# AWS provider configuration
############################################
provider "aws" {
  # All resources will be created in this region
  region = "ap-south-1"
}

############################################
# Data sources
############################################

# Lookup the latest Amazon Linux 2023 AMI
# This is used by the Launch Template later
data "aws_ami" "amazon_linux" {

  # Always fetch the most recent matching AMI
  most_recent = true

  # Official Amazon-owned AMIs only
  owners = ["amazon"]

  # Filter to Amazon Linux 2023 x86_64 images
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

############################################
# Modules
############################################

# ECR module
# Creates an immutable ECR repository for Docker images
module "ecr" {
  source = "./modules/ecr"
}
