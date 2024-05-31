terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
resource "aws_ecs_service" "notification_service" {
  name            = "notification-service"
  cluster         = aws_ecs_cluster.mycluster.id
  task_definition = aws_ecs_task_definition.notification_task.arn
  desired_count   = 2
  launch_type     = "FARGATE"
  platform_version = "LATEST"

  network_configuration {
    assign_public_ip = false
    subnets          = var.subnet_ids
    security_groups  = [aws_security_group.lb_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.main.arn
    container_name   = "notification-service"
    container_port   = 3000
  }
}
