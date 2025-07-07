
output "dns" {
    value = module.alb.alb_dns_name
}


output "latest_task_definition_arn" {
  value = module.ecs.task_definition_arn
  description = "The latest ECS task definition ARN"
}
