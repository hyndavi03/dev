variable "region" {
  description = "The AWS region to deploy into"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_id" {
  description = "The VPC ID where resources will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs where resources will be deployed"
  type        = list(string)
}
