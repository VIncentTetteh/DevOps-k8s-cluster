resource "aws_vpc" "tt-devops" {
  cidr_block                       = "10.0.0.0/16"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false
  enable_classiclink               = false

  tags = {
    "Name" = "tt-devops-vpc"
  }
}