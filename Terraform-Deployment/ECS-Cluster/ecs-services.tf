resource "aws_ecs_service" "technova-cluster-service" {
  name            = "cluster-service"
  cluster         = aws_ecs_cluster.technova-cluster.id
  task_definition = aws_ecs_task_definition.TD.arn
  desired_count   = 2 
  launch_type = "FARGATE"

    deployment_controller {
    type = "CODE_DEPLOY"
  }

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = var.security_group_id
    assign_public_ip = true
  }
    health_check_grace_period_seconds = 430# ✅ CORRECT PLACE
  

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "technova"
    container_port   = 3000
  }

    lifecycle {
    ignore_changes = [task_definition]
  }

}
