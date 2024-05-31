variable "region" {
  default = "ap-south-1"
}
variable "vpc_id" {
  description = "The VPC ID where the ECS cluster is deployed"
}

variable "subnet_ids" {
  description = "The subnets IDs where the ECS cluster is deployed"
  type        = list(string)
}
