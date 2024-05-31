resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs_task_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  ]
}

resource "aws_ecs_task_definition" "notification_task" {
  family                   = "notification-task"
  container_definitions    = jsonencode([
    {
      name      = "notification-service"
      image     = "${aws_ecr_repository.notification_service.repository_url}:latest"
      essential = true
      memory    = 512
      cpu       = 256
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
}
