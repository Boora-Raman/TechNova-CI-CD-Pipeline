output "cluster-name" {
    value= aws_ecs_cluster.technova-cluster.name 
}

output "service-name" {
  value = aws_ecs_service.technova-cluster-service.name
}