terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

resource "aws_ecs_cluster" "mycluster" {
  name = "notification_cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
