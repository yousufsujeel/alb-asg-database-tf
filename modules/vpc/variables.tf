variable "region" {
      description = "AWS region where vpc needs to be deployed"
      type        = string
}
variable "project_name" {
     description = "Name of the project."
      type        = string
}
variable "env" {
     description = "Environment (e.g., dev, prod, staging)."
      type        = string
}
variable "vpc_cidr" {
     description = "CIDR range for the VPC."
     type        = string
}
variable "public_subnet_az1_cidr" {
     description = "CIDR range for the public subnet in availability zone 1"
     type        = string
}
variable "public_subnet_az2_cidr" {
      description = "CIDR range for the public subnet in availability zone 2."
      type        = string
}
variable "private_app_subnet_az1_cidr" {
      description = "CIDR range for the private app subnet in availability zone 1"
      type        = string
}
variable "private_app_subnet_az2_cidr" {
      description = "CIDR range for the private app subnet in availability zone 2"
      type        = string
}
variable "private_data_subnet_az1_cidr" {
      description = "CIDR range for the private data subnet in availability zone 1"
      type        = string
}
variable "private_data_subnet_az2_cidr" {
      description = "CIDR range for the private data subnet in availability zone 2."
      type        = string
}
variable "common_tags" {
      description = "Common tags"
      type        =  map
}
