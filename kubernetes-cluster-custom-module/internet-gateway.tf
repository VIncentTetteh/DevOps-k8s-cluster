resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.tt-devops.id

  tags = {
    Name = "tt-devops-igw"
  }
}