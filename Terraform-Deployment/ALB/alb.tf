# Application Load Balancer
resource "aws_lb" "test" {
  name               = "technova-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_id
  subnets            = var.subnet_ids

  tags = {
    Environment = "production"
    Name        = "TechnovaALB"
  }
}

# Blue Target Group
resource "aws_lb_target_group" "technova_blue_tg" {
  name                 = "technova-ecs-tg-blue"
  port                 = 3000
  protocol             = "HTTP"
  vpc_id               = var.vpc_id
  target_type          = "ip"
  deregistration_delay = 80

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "3000"
    interval            = 50
    timeout             = 30
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }

  tags = {
    Name = "TechnovaBlueTargetGroup"
  }
}

# Green Target Group
resource "aws_lb_target_group" "technova_green_tg" {
  name                 = "technova-ecs-tg-green"
  port                 = 3000
  protocol             = "HTTP"
  vpc_id               = var.vpc_id
  target_type          = "ip"
  deregistration_delay = 80

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "3000"
    interval            = 50
    timeout             = 30
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }

  tags = {
    Name = "TechnovaGreenTargetGroup"
  }
}

# ALB Listener (Initially forwards to Blue Target Group)
resource "aws_lb_listener" "Listener" {
  load_balancer_arn = aws_lb.test.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.technova_blue_tg.arn
  }

  tags = {
    Name = "TechnovaHTTPListener"
  }
}
