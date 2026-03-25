############################################
# AMI ID
############################################
# Base OS image used to launch EC2 instances
# (Amazon Linux 2023 in our case)

variable "ami_id" {
  type = string
}

############################################
# IMAGE TAG
############################################
# Docker image version (Git commit SHA)
# Passed from CI/CD → used to pull correct image from ECR

variable "image_tag" {
  type = string
}

############################################
# SUBNET IDS
############################################
# List of subnets where EC2 instances will run
# Used by Auto Scaling Group to distribute instances across AZs

variable "subnet_ids" {
  type = list(string)
}

############################################
# TARGET GROUP ARN
############################################
# Connects EC2 instances to ALB
# Instances register here → ALB routes traffic to them

variable "target_group_arn" {
  type = string
}

############################################
# ALB SECURITY GROUP ID
############################################
# Used to allow ONLY ALB → EC2 traffic on port 8000
# Prevents direct public access to EC2

variable "alb_security_group_id" {
  type = string
}

############################################
# VPC ID
############################################
# Defines which network (VPC) EC2 instances belong to

variable "vpc_id" {
  type = string
}

############################################
# SERVICE NAME
############################################
# Logical name of our application (ehr)
# Used for naming resources (SG, LT, ASG, etc.)

variable "service_name" {
  type = string
}

############################################
# INSTANCE PROFILE NAME
############################################
# IAM role attached to EC2 instances
# Allows:
# → Pulling images from ECR
# → Access via SSM 

variable "instance_profile_name" {
  description = "IAM instance profile name for EC2 instances"
  type        = string
}

############################################
# REGION
############################################
# AWS region (ap-south-1)
# Used for ECR login and other AWS operations

variable "region" {
  type = string
}

############################################
# REPOSITORY URL
############################################
# ECR repository URL
# Used in user-data to pull Docker image

variable "repository_url" {
  type = string
}

############################################
# VPC CIDR
############################################
# Used to allow internal VPC access to EC2
# Example:
# → Monitoring EC2 (Prometheus) can scrape metrics on port 9100
# → No need to reference monitoring SG

variable "vpc_cidr" {
  description = "CIDR block of VPC for internal access"
  type        = string
}
