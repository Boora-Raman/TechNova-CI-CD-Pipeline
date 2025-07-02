resource "aws_ecs_cluster" "technova-cluster" {
  name = "technova-deployment-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    name = "technova-Deployment-ECS-workspace"
  }
}
