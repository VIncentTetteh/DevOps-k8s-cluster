resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.tt-devops.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = true

  tags = {
    Name                        = "public-us-east-2a"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }
}


resource "aws_subnet" "private_1" {
  vpc_id                  = aws_vpc.tt-devops.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = true

  tags = {
    Name                        = "private-us-east-2b"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }
}

resource "aws_subnet" "private_2" {
  vpc_id                  = aws_vpc.tt-devops.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-2c"
  map_public_ip_on_launch = true

  tags = {
    Name                        = "private-us-east-2c"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }
}