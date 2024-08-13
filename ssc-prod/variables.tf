
variable "region" {
  description = "The AWS region where resources will be deployed."
  type        = string
}

variable "project_name" {
  description = "The name of the project, used to identify related resources."
  type        = string
}

variable "env" {
  description = "The environment in which the resources are deployed (e.g., dev, prod, staging)."
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR range for the Virtual Private Cloud (VPC)."
  type        = string
}

variable "public_subnet_az1_cidr" {
  description = "The CIDR range for the public subnet in availability zone 1."
  type        = string
}

variable "public_subnet_az2_cidr" {
  description = "The CIDR range for the public subnet in availability zone 2."
  type        = string
}

variable "private_app_subnet_az1_cidr" {
  description = "The CIDR range for the private application subnet in availability zone 1."
  type        = string
}

variable "private_app_subnet_az2_cidr" {
  description = "The CIDR range for the private application subnet in availability zone 2."
  type        = string
}

variable "private_data_subnet_az1_cidr" {
  description = "The CIDR range for the private data subnet in availability zone 1."
  type        = string
}

variable "private_data_subnet_az2_cidr" {
  description = "The CIDR range for the private data subnet in availability zone 2."
  type        = string
}

variable "domain_name" {
  description = "The primary domain name for the application or service."
  type        = string
}

variable "alternative_name" {
  description = "An alternative domain name or a list of additional domain names for the application or service."
  type        = string
}

variable "ami_id" {
  description = "The Amazon Machine Image (AMI) ID to use for launching EC2 instances."
  type        = string
}

variable "desired_capacity" {
  description = "The desired number of instances in the Auto Scaling group."
  type        = number
}

variable "max_size" {
  description = "The maximum number of instances in the Auto Scaling group."
  type        = number
}

variable "min_size" {
  description = "The minimum number of instances in the Auto Scaling group."
  type        = number
}

variable "instance_type" {
  description = "The type of EC2 instance to launch (e.g., t2.micro, m5.large)."
  type        = string
}

variable "key_name" {
  description = "The name of the key pair to use for SSH access to the instances."
  type        = string
}

variable "high_network_in_threshold" {
  description = "The threshold for high network inbound traffic, used for scaling policies."
  type        = number
}

variable "low_network_in_threshold" {
  description = "The threshold for low network inbound traffic, used for scaling policies."
  type        = number
}
variable "CostCenter" {
  description = "Cost Center of Application"
  type        = string
  default     = "ssc_cost_center"
}   

variable "ApplicationID" {
  description = "ApplicationID of Application"
  type        = string
  default     = "ssc_appid"
}

