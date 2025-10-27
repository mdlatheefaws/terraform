variable "aws_region" {
description = "AWS region to deploy resouce"
type = string

}


variable "vpc_cidr" {
description = "Demo_VPC_CIDR"
type = string
}

variable "vpc_name" {
description = "My vpcname"
type = string
}

# variable "instance_type" {
#         type = string
#     default = "t3.medium"
#   }
variable "ami_id" {
        type = string
    
  }

variable "instance_type" {
 type = map(string) 
  default = {
    dev  = "t2.micro"
    prod = "t3.small"
    uat =  "t2.micro"
  }
}


variable "environment" {
  type = string 
}

variable "key_name" {
        type = string
    
  }

  variable "instance_name" {
        type = string
   
  }
  variable "ec2-count" {
    type = string
       
  }
## varible for SG#########
variable "sg-name" {
        type = string
   
  }
  #ssh ingrees
variable "cidr_blocks" {
        type = string
      }

variable "from_port" {
  type = string
  
}

variable "to_port" {
  type = string
  }

variable "pro-ssh" {
  type = string
  }
## ICMP

variable "from_port_icmp" {
  type = string
 
}

variable "to_port_icmp" {
  type = string
 
}

#### Pub-subnets ##########
# variable "PUB-subnets" {
#   type = list(string)
#   default = [ "30.0.2.0/24", "30.0.3.0/24" ]
# }
# variable "pub_subnets" {
#   type = map(object( {
#     cidr = string 
#     az   = string
#   }))
 
#   default = {
#     pub-subnet-1 =  { cidr = "30.0.2.0/24", az = "ap-south-1a" }
#     pub-subnet-2 =  { cidr = "30.0.3.0/24", az = "ap-south-1b" }
#   }
# }
# variable "PUB-SUB-Name" {
#   type = string
  
# }

# #### Pvt-subnets ##########
# variable "Pvt_subnets" {
#   type = map(object( {
#     cidr = string 
#     az   = string
#   }))
 
#   default = {
#     pvt-subnet-1 =  { cidr = "30.0.4.0/24", az = "ap-south-1a" }
#     pvt-subnet-2 =  { cidr = "30.0.5.0/24", az = "ap-south-1b" }
#   }
# }

variable "pub_subnets" {
  description = "Map of public subnets with CIDR and AZ"
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "PUB-SUB-Name" {
  description = "Name prefix for public subnets"
  type        = string
}

variable "Pvt_subnets" {
  description = "Map of private subnets with CIDR and AZ"
  type = map(object({
    cidr = string
    az   = string
  }))
}


variable "Pvt-SUB-Name" {
  type = string
}
