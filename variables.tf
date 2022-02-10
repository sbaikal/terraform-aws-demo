

# Subnet id
variable "subnet_id" {
  type        = string
  description = "subnet id"
  default     = ""
}

variable "instance_type" {
  type        = string
  description = "instance type"
  default     = ""
}

# Root volume variables
variable "root_volume_size" {
  type        = number
  description = "root volume size"
  default     = null
}


# EC2 sg variables
variable "sg_name" {
  type        = string
  description = "ec2 server sg name"
  default     = ""
}


variable "http_ip_ingress" {
  type        = list(string)
  description = "local ip ingress"
  default     = ["0.0.0.0/0"]
}
variable "ssh_ip_ingress" {
  type        = list(string)
  description = "local ip ingress"
  default     = ["0.0.0.0/0"]
}


# Tag variables
variable "env" {
  type        = string
  description = "environment"
  default     = ""
}


variable "project" {
  type        = string
  description = "name of the project"
  default     = ""

}

variable "cidr_block" {
  type        = string
  description = "cidr block of subnet1"
  default     = "10.0.0.0/24"
}
# VPC variables
variable "vpc_cidr_block" {
  type        = string
  description = "cidr block of vpc"
  default     = "10.0.0.0/16"

}

# VPC id
variable "vpc_id" {
  type        = string
  description = "vpc id"
  default     = ""
}

# Providers variable
variable "aws_region" {
  type        = string
  description = "The region Terraform deploys your infra"
  default     = ""
}

# Subnet variables
variable "aws_az_1a" {
  type        = string
  description = "The region Terraform deploys your infra"
  default     = ""
}

variable "pub_cidr_subnet" {
  type        = string
  description = "cidr block for the public subnet"
  default     = ""
}

# EC2 variables
#variable "image_id" {
#  type        = string
#  description = "redhat ami"

#  default     = ""
#}

variable "ebs_volume_type" {
  type        = string
  description = "ebs volume type"
  default     = ""
}