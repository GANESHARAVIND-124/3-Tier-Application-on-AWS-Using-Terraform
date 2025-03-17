variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"  # ✅ Fix: Single value, not a list
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24","10.0.3.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24","10.0.6.0/24"]
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
  default = "3-tier-app-keypair"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "ec2_sg_id" {
  description = "Security Group ID for EC2 instances"
  type        = string
}

variable "alb_sg_id" {
  description = "Security Group ID for ALB"
  type        = string
}

variable "target_group_arn" {
  description = "Target Group ARN for ALB"
  type        = string
}


variable "db_password" {
  description = "Database master password"
  type        = string
  sensitive   = true
  default = "StrongPass123!"
}

variable "availability_zones" {
  description = "List of availability Zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]  # ✅ Ensure three AZs
}

































