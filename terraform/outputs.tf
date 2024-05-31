output "ecr_repository_url" {
  value = aws_ecr_repository.notification_service.repository_url
}

output "cluster_id" {
  value = element(aws_ecs_cluster.mycluster[*].id, 0)
}

