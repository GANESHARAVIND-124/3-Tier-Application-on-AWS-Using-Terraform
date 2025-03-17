# Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
    domain = "vpc"

    tags = {
      Name = "NAT-EIP"
    }
}

#NAT Gateway in a public subnet

resource "aws_nat_gateway" "nat" {

    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.public[0].id
  
  tags = {
    Name = "NAT-Gateway"
  }

  depends_on = [ aws_internet_gateway.igw ]
}

# Route Table for private Subnets

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat.id
    }

    tags = {
      Name = "Private-Route-Table"
    }

}

#Associate Private Subnets with Private Route Table

resource "aws_route_table_association" "private" {
    count = length(var.private_subnets)
    subnet_id = aws_subnet.private[count.index].id
    route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id 
  route_table_id = aws_route_table.public_rt.id
}
