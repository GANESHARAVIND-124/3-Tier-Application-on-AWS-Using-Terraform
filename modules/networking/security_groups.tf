resource "aws_security_group" "alb_sg" {
  vpc_id = aws_vpc.main.id

    # Allow inbound HTTP/HTTPS traffic

    ingress  {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Allow outbound HTTP/HTTPS traffic

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "ALB-SG"
    }
}

resource "aws_security_group" "ec2_sg" {
  vpc_id = aws_vpc.main.id

    # Allow inbound HTTP/HTTPS traffic

        ingress {
            from_port   = 80
            to_port     = 80
            protocol    = "tcp"
            security_groups = [aws_security_group.alb_sg.id]  # ✅ Correct syntax
        }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Allow outbound HTTP/HTTPS traffic

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "EC@2-SG"
    }
}

resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.main.id

    # Allow inbound HTTP/HTTPS traffic

    ingress  {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = [aws_security_group.ec2_sg.id]
    }

    # Allow outbound HTTP/HTTPS traffic

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "RDS-SG"
    }
}
