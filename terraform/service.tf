resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role"
  # other role configurations
}

resource "aws_ecs_task_definition" "notification_task" {
  # other task definition configurations
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_execution_role.arn
}
