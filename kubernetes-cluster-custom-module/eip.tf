resource "aws_eip" "tt-nat" {
  depends_on = [aws_internet_gateway.gw]

}