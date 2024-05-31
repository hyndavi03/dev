# Check if the ECS cluster already exists
data "aws_ecs_cluster" "existing_cluster" {
  cluster_name = "notification_service"  # Assuming "notification_service" is the cluster name
}



# Check if the IAM role already exists
data "aws_iam_role" "existing_role" {
  name = "ecs_task_execution_role"
}

# Create the ECS cluster if it doesn't exist
resource "aws_ecs_cluster" "mycluster" {
  count = length(data.aws_ecs_cluster.existing_cluster) == 0 ? 1 : 0
  
  name = "notification_cluster"
  # Add other configuration options as needed
}

# Create the IAM role if it doesn't exist
resource "aws_iam_role" "ecs_task_execution_role" {
  count = length(data.aws_iam_role.existing_role) == 0 ? 1 : 0

  name               = "ecs_task_execution_role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }]
  })
  # Add other configuration options as needed
}

# Continue with other resources like ECS service, etc.
