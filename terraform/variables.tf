variable "region" {
  default = "ap-south-1"
}
variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type    = list(string)
  default = []  # Set default value if needed
}

