output "ecr_repository_url" {
  description = "URL of the ECR repository for Docker pushes"
  value       = module.ecr.repository_url
}
