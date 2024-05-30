 resource "aws_ecs_service" "service" {
  name            = "notification-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = ["subnet-03b108e1dafc6f9e5"]
    security_groups = ["sg-01f2e8a08f271674d"]
  }
}

