output "cluster-name" {
    value= aws_ecs_cluster.technova-cluster.name 
}

output "service-name" {
  value = aws_ecs_service.technova-cluster-service.name
}

output "task_definition_arn" {
  value       = aws_ecs_task_definition.TD.arn
  description = "ARN of the ECS task definition for Strapi"
  
}
