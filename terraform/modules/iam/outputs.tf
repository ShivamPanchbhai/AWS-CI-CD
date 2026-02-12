#############################
# Outputs for IAM module
#############################

output "instance_profile_name" {
  value = aws_iam_instance_profile.ec2_runtime.name
}
