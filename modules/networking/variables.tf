variable "vpc_cidr" {
  description = "ID of the VPC"
  type = string
}

variable "public_subnets" {
  description = "List of public subnet CIDR's"
  type = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDR's"
  type = list(string)
}

variable "availability_zones" {
  description = "List of availability Zones"
  type = list(string)
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH into EC2 instances"
  type        = string
  default     = "0.0.0.0/0"  # Change this to your IP for security
}
