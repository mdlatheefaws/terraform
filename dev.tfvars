aws_region = "ap-south-1"
vpc_cidr = "40.0.0.0/16"
vpc_name = "DEV_vpc"
ami_id =  "ami-07f07a6e1060cd2a8"
environment = "DEV"
key_name = "minikubekey"
instance_name = "demo_instance"
ec2-count = "3"
sg-name = "Demo_vpc_SG"
cidr_blocks = "0.0.0.0/0"
from_port = "22"
to_port = "22"
pro-ssh = "tcp"
from_port_icmp = "-1"
to_port_icmp = "-1"
PUB-SUB-Name = "DEV-vpc_pub_sub"
Pvt-SUB-Name = "DEV-vpc_pvt_sub"
pub_subnets = {
  DEV-pub-subnet-1 = {
    cidr = "40.0.2.0/24"
    az   = "ap-south-1a"
  }
  DEV-pub-subnet-2 = {
    cidr = "40.0.3.0/24"
    az   = "ap-south-1b"
  }
}

Pvt_subnets = {
  DEV-pvt-subnet-1 = {
    cidr = "40.0.4.0/24"
    az   = "ap-south-1a"
  }
  DEV-pvt-subnet-2 = {
    cidr = "40.0.5.0/24"
    az   = "ap-south-1b"
  }
}

