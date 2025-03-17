output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}


output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id  # ✅ Ensure this security group is created in networking
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id  # ✅ Ensure this security group is created in networking
}
