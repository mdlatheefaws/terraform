aws_region = "ap-south-1"
vpc_cidr = "30.0.0.0/16"
vpc_name = "Prod_Env_Vpc"
ami_id =  "ami-07f07a6e1060cd2a8"
environment = "prod"
key_name = "minikubekey"
instance_name = "prod_instance"
ec2-count = "3"
sg-name = "Prod_vpc_SG"
cidr_blocks = "0.0.0.0/0"
from_port = "22"
to_port = "22"
pro-ssh = "tcp"
from_port_icmp = "-1"
to_port_icmp = "-1"
PUB-SUB-Name = "Prodvpc_pub_sub"
Pvt-SUB-Name = "Prodvpc_pvt_sub"    
pub_subnets = {
  Prod-pub-subnet-1 = {
    cidr = "30.0.2.0/24"
    az   = "ap-south-1a"
  }
  Prod-pub-subnet-2 = {
    cidr = "30.0.3.0/24"
    az   = "ap-south-1b"
  }
}

Pvt_subnets = {
  Prod-pvt-subnet-1 = {
    cidr = "30.0.4.0/24"
    az   = "ap-south-1a"
  }
  Prod-pvt-subnet-2 = {
    cidr = "30.0.5.0/24"
    az   = "ap-south-1b"
  }
}

instance_type = {
  
    dev  = "t2.micro"
    prod = "t3.small"
    uat  = "t2.micro"
}
