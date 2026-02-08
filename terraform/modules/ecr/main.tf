# Use existing ECR repository (pre-created)
data "aws_ecr_repository" "ehr" {
  name = "ehr-service"
}
