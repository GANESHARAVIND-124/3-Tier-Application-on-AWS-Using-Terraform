variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "ec2_sg_id" {
  description = "Security Group ID for EC2"
  type        = string
}

variable "db_password" {
  description = "Database Master Password"
  type        = string
  sensitive   = true
  default     = "StrongPass123!"  # ✅ At least 8 characters
}
