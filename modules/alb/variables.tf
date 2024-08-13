variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "env" {
  description = "Environment (e.g., dev, prod, staging)"
  type        = string
}

variable "alb_security_group_id" {
  description = "Security Group ID for the Application Load Balancer"
  type        = string
}

variable "public_subnet_az1_id" {
  description = "ID of the public subnet in availability zone 1"
  type        = string
}

variable "public_subnet_az2_id" {
  description = "ID of the public subnet in availability zone 2"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "certificate_arn" {
  description = "ARN of the SSL/TLS certificate"
  type        = string
}
variable "common_tags" {
      description = "Common tags"
      type        =  map
}