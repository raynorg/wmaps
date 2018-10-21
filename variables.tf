variable "vpc_cidr" {
  description = "CIDR block for subnet"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "subnet cidr"
  default     = "10.0.2.0/24"
}

variable "subnet_cidr2" {
  description = "subnet2 cidr"
  default     = "10.0.1.0/24"
}

variable "key_path" {
  description = "path to ssh key for instance"
  default     = ""
}

variable "subnet_name" {
  description = "name of subnet"
  default     = "dev_subnet"
}

variable "subnet_name2" {
  description = "subnet2 name"
  default     = "subnet2"
}

variable "aws_region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "subnet_rt_name" {
  description = "subnet route table name"
  default     = "dev_subnet_rt"
}

variable "vpc_name" {
  description = "Name of VPC"
  default     = "dev_vpc"
}

variable "vpc_gateway_name" {
  description = "gateway name"
  default     = "gw_dev"
}

variable "sec_group_name" {
  description = "Security Group Name"
  default     = "dev_sg"
}

variable "availability_zone" {
  description = "AZ to use"
  default     = "us-east-1a"
}

variable "availability_zone2" {
  description = "AZ2"
  default     = "us-east-1b"
}

variable "key_name" {
  description = "ssh key name"
  default     = ""
}

variable "container_name" {
  default = "weedmaps-forum"
}

variable "container_image" {
  default = "374926483868.dkr.ecr.us-east-1.amazonaws.com/weedmaps:latest"
}
