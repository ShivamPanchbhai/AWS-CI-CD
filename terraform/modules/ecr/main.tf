# Create an ECR repository inside AWS to store Docker images for the service
resource "aws_ecr_repository" "ehr" {

  # Name of the ECR repository
  name = "ehr-service"

  # Enforce immutable tags
  # Once an image with a tag is pushed, it cannot be overwritten
  image_tag_mutability = "IMMUTABLE"

  # Enable vulnerability scanning when an image is pushed
  image_scanning_configuration {

    # Automatically scan images on every push
    scan_on_push = true
  }

lifecycle {
    prevent_destroy = true
  }
}
