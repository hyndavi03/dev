variable "region" {
  description = "The AWS region to deploy into"
  type        = string
  default     = "ap-south-1"
}

variable "subnet_ids" {
  description = "A list of subnet IDs to associate with the load balancer"
  type        = list(string)
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}
