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
      image = "booraraman/technova-app:3a34781373c4c003c0e81ec1d746c41cf232288b"
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

