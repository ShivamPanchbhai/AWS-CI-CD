############################################
# ALB outputs
############################################

# Public DNS name of the load balancer
output "alb_dns_name" {
  value = aws_lb.this.dns_name
}

# Target Group ARN
# Used by compute (ASG) module
output "target_group_arn" {
  value = aws_lb_target_group.this.arn
}

