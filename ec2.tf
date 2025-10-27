resource "aws_instance" "demo_instance-pub" {
   for_each = var.pub_subnets
   ami = var.ami_id
   instance_type = lookup(var.instance_type,var.environment)
   key_name = var.key_name
   vpc_security_group_ids = [aws_security_group.Demo_vpc_SG.id]
   subnet_id     = aws_subnet.public-subnets[each.key].id
   
   associate_public_ip_address = true
   tags = {
     #Name = var.instance_name
     Name = "PUB-${each.key}"

   }
 }

# resource "aws_instance" "demo_instance-pvt" {
#    for_each = var.Pvt_subnets
#    ami = var.ami_id
#    instance_type = lookup(var.instance_type,var.environment)
#    key_name = var.key_name
#    vpc_security_group_ids = [aws_security_group.Demo_vpc_SG.id]
#    subnet_id     = aws_subnet.Pvt_subnets[each.key].id
   
#    associate_public_ip_address = false
#    tags = {
#      #Name = var.instance_name
#      Name = "PVT-${each.key}"

#    }
#  }