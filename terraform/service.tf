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

resource "aws_security_group" "lb_sg" {
  name        = "lb_sg-${random_id.lb_sg_suffix.hex}"
  description = "Allow HTTP inbound traffic"
  vpc_id      = "vpc-0fb809d348139ac47"

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "random_id" "lb_sg_suffix" {
  byte_length = 4
}
