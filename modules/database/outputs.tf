output "rds_endpoint" {
  description = "RDS database endpoint"
  value       = aws_db_instance.app_rds.endpoint
}

output "rds_security_group_id" {
  description = "Security Group ID for RDS"
  value       = aws_security_group.rds_sg.id
}
