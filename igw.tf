resource "aws_internet_gateway" "Demo_vpc_igw" {
 vpc_id = aws_vpc.Demo_vpc.id
 tags = {
    Name = "Demo_vpc_igw"
  }
}
