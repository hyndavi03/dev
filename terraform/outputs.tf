output "cluster_id" {
  value = aws_ecs_cluster.mycluster.id
}

output "ecr_repository_url" {
  value = aws_ecr_repository.notification_service.repository_url
}
