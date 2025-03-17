# Create an application Load Balancer (ALB)

resource "aws_alb" "app_alb" {
    name = "app-load-balancer"
    internal = false
    load_balancer_type = "application"
    security_groups = [ var.alb_sg_id]
    subnets = var.public_subnet_ids

    enable_deletion_protection = false

    tags = {
      name = "App-ALB"
    }
}

#ALB Listener for HTTP traffic

resource "aws_lb_listener" "HTTP" {
  load_balancer_arn = aws_alb.app_alb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

resource "aws_lb_target_group" "app_tg" {
    name = "app-target-group"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id

    health_check {
      path = "/"
      interval = 30
      timeout = 5
      healthy_threshold = 2
      unhealthy_threshold = 2
    }

    tags = {
      name = "App-TG"
    }
}