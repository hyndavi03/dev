resource "aws_lb" "main" {
  name               = "notification-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = ["subnet-03b108e1dafc6f9e5"]  # Replace with your subnet IDs

  enable_deletion_protection = false
}

output "load_balancer_dns_name" {
  value = aws_lb.main.dns_name
}
output "cluster_id" {
  value = aws_ecs_cluster.mycluster.id
}

output "ecr_repository_url" {
  value = aws_ecr_repository.notification_service.repository_url
}