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
      image = "booraraman/technova-app:db5d77496e95914707211e3e626b1821a45e5e3c"
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

