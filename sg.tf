resource "aws_security_group" "Demo_vpc_SG" {
 #name   = "Demo_vpc_SG"
  vpc_id = aws_vpc.Demo_vpc.id
  tags = {
    Name = var.sg-name
  }

  ingress  {
  #description = "allow_ssh"  
  cidr_blocks   = [var.cidr_blocks]
  from_port   = var.from_port
  to_port     = var.to_port
  protocol = var.pro-ssh
    }
    
ingress  {
  description = "allow_ICMP"  
  cidr_blocks   = ["0.0.0.0/0"]
  from_port   = var.from_port_icmp
  to_port     = var.to_port_icmp
  protocol = "icmp"
    }

egress  {
description = "all_allow"
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
  }
}