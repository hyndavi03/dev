resource "aws_ecs_service" "notify-service" {
  name            = "note-service"
  cluster         = aws_ecs_cluster.mycluster.id
  task_definition = aws_ecs_task_definition.notify-service.arn
  desired_count   = 3
  iam_role        = aws_iam_role.mycluster.arn
  depends_on      = [aws_iam_role_policy.mycluster]

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.mycluster.arn
    container_name   = "notify-service"
    container_port   = 3000
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [ap-south-1a, ap-south-1b]"
  }
}