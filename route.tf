resource "aws_route_table" "Demo_vpc_pub_rt" {
  for_each = var.pub_subnets
  vpc_id = aws_vpc.Demo_vpc.id
  route {
   cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Demo_vpc_igw.id
  }
  tags = {
    Name = "PUB-RT-${each.key}"
  }
} 
  
resource "aws_route_table" "Demo_vpc_pvt_rt" {
  for_each = var.Pvt_subnets
  vpc_id = aws_vpc.Demo_vpc.id
  
  tags = {
    Name = "PVT-RT-${each.key}"
  }
} 

resource "aws_route_table_association" "public-subnet-assotion" {
  for_each = var.pub_subnets
  subnet_id = aws_subnet.public-subnets[each.key].id
  route_table_id = aws_route_table.Demo_vpc_pub_rt[each.key].id
  
}
resource "aws_route_table_association" "Pvt-subnet-assotion" {
  for_each = var.Pvt_subnets
  subnet_id = aws_subnet.Pvt_subnets[each.key].id
  route_table_id = aws_route_table.Demo_vpc_pvt_rt[each.key].id
  
}