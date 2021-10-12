resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.tt-nat.id
  subnet_id     = aws_subnet.public.id
  tags = {
    "Name" = "tt-devops-nat"
  }
}