resource "aws_ecs_cluster" "mycluster" {
  name = "notification_cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
