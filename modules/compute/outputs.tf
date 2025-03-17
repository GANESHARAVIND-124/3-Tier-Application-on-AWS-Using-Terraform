output "alb_arn" {
  description = "ARN of the ALB"
  value       = aws_alb.app_alb.arn
}

output "alb_dns_name" {
  description = "DNS Name of the ALB"
  value       = aws_alb.app_alb.dns_name
}

output "target_group_arn" {
  description = "Target Group ARN"
  value       = aws_lb_target_group.app_tg.arn
}
output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.app_asg.name
}
