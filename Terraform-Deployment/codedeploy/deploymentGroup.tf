resource "aws_codedeploy_deployment_group" "techonva" {
  app_name              = aws_codedeploy_app.technova.name
  deployment_group_name = "techonva-deploy-group"
  service_role_arn      = module.Iam_roles.codedeploy_role_arn
  deployment_config_name = "CodeDeployDefault.ECSCanary10Percent5Minutes"

  ecs_service {
    cluster_name = module.ecs.cluster-name
    service_name = module.ecs.service-name
  }

  deployment_style {
    deployment_type   = "BLUE_GREEN"
    deployment_option = "WITH_TRAFFIC_CONTROL"
  }


  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [var.alb.listener-arns]
      }
      test_traffic_route {
        listener_arns = [var.alb.test-listener-arns]
      }
      target_group {
        name = var.alb.blue-tg-name
      }
      target_group {
        name = var.alb.green-tg-name
      }
    }
  }

  blue_green_deployment_config {
    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 1
    }
    deployment_ready_option {
      action_on_timeout   = "CONTINUE_DEPLOYMENT"
      wait_time_in_minutes = 0
    }
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}
