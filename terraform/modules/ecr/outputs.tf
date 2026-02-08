data "aws_ecr_repository" "ehr" {
  name = "ehr-service"
}

output "repository_url" {
  value = data.aws_ecr_repository.ehr.repository_url
}
