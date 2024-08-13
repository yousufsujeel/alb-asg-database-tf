variable "vpc_id" {
      description = "VPC id."
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