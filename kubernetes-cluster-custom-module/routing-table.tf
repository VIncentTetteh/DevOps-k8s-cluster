resource "aws_route_table" "public" {
  vpc_id = aws_vpc.tt-devops.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "tt-devops-public"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.tt-devops.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.gw.id
  }

  tags = {
    Name = "tt-devops-private"
  }
}