resource "aws_lb" "main" {
  name               = "notification-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = "subnet-03b108e1dafc6f9e5"

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "main" {
  name     = "notification-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0fb809d348139ac47"
  target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-299"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

resource "aws_security_group" "lb_sg" {
  name        = "lb_sg"
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
output "load_balancer_dns_name" {
  value = aws_lb.main.dns_name
}
output "cluster_id" {
  value = aws_ecs_cluster.mycluster.id
}

output "ecr_repository_url" {
  value = aws_ecr_repository.notification_service.repository_url
}