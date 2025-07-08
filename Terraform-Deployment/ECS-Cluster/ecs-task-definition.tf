resource "aws_ecs_task_definition" "TD" {
    family                   = "technova-service"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "4096"
  memory                   = "8192"
  execution_role_arn       = var.execution_role_arn
  container_definitions = jsonencode([
    {
      name  = "technova"
      image = "booraraman/technova-app:b55d9902f84c8d3ee8c972e04856ff9637d88314"
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/technova-service"
          "awslogs-region"        = "us-east-2"
          "awslogs-stream-prefix" = "technova"
          "awslogs-create-group"  = "true"
        }
      }
    }
  ])

  lifecycle {
    create_before_destroy = true
  }
}

