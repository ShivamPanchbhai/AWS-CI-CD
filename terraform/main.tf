terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }

  backend "s3" {
    bucket = "shivam-terraform-state-3069"
    key    = "ec2/terraform.tfstate"
    region = "ap-south-1"
  }

} # terraform block ends

provider "aws" {
  region = "ap-south-1"
} # provider block ends

# Get latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux" { # lookup query
  most_recent = true            # picks the newest one
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}
