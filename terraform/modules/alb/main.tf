############################################
# Application Load Balancer
############################################
resource "aws_lb" "this" {
  name               = "${var.service_name}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_ids

  enable_deletion_protection = false
}

############################################
# Target Group for EC2 (FastAPI via nginx)
############################################
resource "aws_lb_target_group" "this" {
  name     = "${var.service_name}-tg"
  port     = 8000
  protocol = "HTTP"
  vpc_id  = var.vpc_id

  health_check {
    path                = "/health"
    matcher             = "200"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

