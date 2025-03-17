resource "aws_iam_role" "ec2_role" {
  name = "ec2-instance-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}


#IAM Policy Attachment for EC2 Role

resource "aws_iam_policy_attachment" "ec2_policy_attachment" {
    name = "ec2-policy-attachment"
    roles = [aws_iam_role.ec2_role.name]
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

#IAM Instance Profile

resource "aws_iam_instance_profile" "ec2_instance_profile" {
    name = "ec2-instace-profile"
    role = aws_iam_role.ec2_role.name
}

# Launch Template for EC2 Instances
resource "aws_launch_template" "app_lt" {
  name          = "app-launch-template"
  image_id      = "ami-04b4f1a9cf54c11d0"  # ✅ Ubuntu AMI
  instance_type = "t2.micro"
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = element(var.public_subnet_ids,0)
    security_groups             = [var.ec2_sg_id]
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_instance_profile.name
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    echo "Starting application..."
    sudo apt update -y
    sudo apt install -y nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx
  EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "App-Instance"
    }
  }
}
