resource "aws_codedeploy_app" "technova" {
  name             = "technova-codedeploy"
  compute_platform = "ECS"
}

