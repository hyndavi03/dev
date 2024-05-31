provider "aws" {
  region = "ap-south-1"
}

resource "aws_ecs_cluster" "mycluster" {
  name = "notification_cluster"
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs_task_execution_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}

resource "aws_ecs_task_definition" "notification_task" {
  family                   = "notification-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = jsonencode([{
    name  = "notification-service"
    image = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/notification-service:latest"
    essential = true
    portMappings = [{
      containerPort = 3000
      hostPort      = 3000
    }]
  }])
}

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
