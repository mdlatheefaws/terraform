variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_profile" {
  type    = string
  default = "default"
}

variable "name_suffix" {
  type    = string
  default = "lab01"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "instance_type_master" {
  type    = string
  default = "t3.medium"
}

variable "instance_type_worker" {
  type    = string
  default = "t3.small"
}

variable "worker_count" {
  type    = number
  default = 2
}

variable "ssh_key_name" {
  type = string
  default = "ubuntu-ap-key"
  description = "Existing AWS EC2 KeyPair name to use for SSH"
}

variable "ubuntu_ami" {
  type    = string
  default = "ami-087d1c9a513324697"
  description = "Ubuntu 22.04 AMI id for your region (replace with correct AMI)"
}
