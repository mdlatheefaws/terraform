# resource "aws_subnet" "public-subnets" {
#   count = length(var.PUB-subnets)
#   cidr_block = var.PUB-subnets[count.index]
#   vpc_id = aws_vpc.Demo_vpc.id
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "pub-sub-${count.index + 1}"
#   }
# }
# resource "aws_subnet" "public-subnets" {
#   for_each = var.pub_subnets
#   cidr_block = each.value.cidr
#   vpc_id = aws_vpc.Demo_vpc.id
#   availability_zone = each.value.az
#   map_public_ip_on_launch = true
#   tags = {
#     Name = each.key
#   }
# }

resource "aws_subnet" "public-subnets" {
  for_each = var.pub_subnets 
  cidr_block = each.value.cidr
  vpc_id = aws_vpc.Demo_vpc.id
  availability_zone = each.value.az
  map_public_ip_on_launch = true
 
  tags = {
    Name = each.key
  }
}


resource "aws_subnet" "Pvt_subnets" {
 for_each = var.Pvt_subnets
  cidr_block = each.value.cidr
  vpc_id = aws_vpc.Demo_vpc.id
  
  tags = {
    Name = each.key
  }
}
