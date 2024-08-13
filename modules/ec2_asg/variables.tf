variable "project_name" {
     description = "Name of the project."
      type        = string
}
variable "env" {
     description = "Environment (e.g., dev, prod, staging)."
      type        = string
}
variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  default     = "t3.micro"
}

variable "key_name" {
  description = "Key pair name"
}

variable "user_data_base64" {
  type        = string
  description = "The Base64-encoded user data to provide when launching the instances"
  default     = ""
}
variable "target_group_arn" {
  description = "ARN of the target group"
}

variable "desired_capacity" {
  description = "Desired number of EC2 instances"
  default     = 1
}

variable "max_size" {
  description = "Maximum number of EC2 instances"
  default     = 3
}

variable "min_size" {
  description = "Minimum number of EC2 instances"
  default     = 1
}


variable "vpc_zone_identifier" {
  description = "List of Subnets"
}

variable "ec2_security_group_id" {
  description = "List of Security Groups"
  type        = list(string)
}
variable "high_network_in_threshold" {
  description = "Threshold for scaling up based on NetworkIn (bytes)"
  default     = 50000000 # 50 MB
}

variable "low_network_in_threshold" {
  description = "Threshold for scaling down based on NetworkIn (bytes)"
  default     = 20000000 # 20 MB
}