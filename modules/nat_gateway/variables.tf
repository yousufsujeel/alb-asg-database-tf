
variable "public_subnet_az1_id" {
  description = "The ID of the public subnet in availability zone 1."
  type        = string
}

variable "internet_gateway" {
  description = "The ID of the internet gateway attached to the VPC."
  type        = string
}

variable "public_subnet_az2_id" {
  description = "The ID of the public subnet in availability zone 2."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the Virtual Private Cloud (VPC) where the resources are deployed."
  type        = string
}

variable "private_app_subnet_az1_id" {
  description = "The ID of the private application subnet in availability zone 1."
  type        = string
}

variable "private_data_subnet_az1_id" {
  description = "The ID of the private data subnet in availability zone 1."
  type        = string
}

variable "private_app_subnet_az2_id" {
  description = "The ID of the private application subnet in availability zone 2."
  type        = string
}

variable "private_data_subnet_az2_id" {
  description = "The ID of the private data subnet in availability zone 2."
  type        = string
}