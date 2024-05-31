resource "aws_ecs_service" "notification_service" {
  name            = "notification-service"
  cluster         = aws_ecs_cluster.mycluster[0].id
  task_definition = aws_ecs_task_definition.notification_task.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = ["subnet-03b108e1dafc6f9e5"]  # Replace with your subnet ID
    security_groups = ["sg-01f2e8a08f271674d"]      # Replace with your security group ID
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.main.arn
    container_name   = "notification-service"
    container_port   = 3000
  }
}





  
