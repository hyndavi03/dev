resource "aws_ecs_service" "notification_service" {
  name            = "notification_service"
  cluster         = aws_ecs_cluster.mycluster.id
  task_definition = aws_ecs_task_definition.notification_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets         = ["subnet-03b108e1dafc6f9e5", "subnet-0f47b25e174d49d09"]
    assign_public_ip = true
  }
}

