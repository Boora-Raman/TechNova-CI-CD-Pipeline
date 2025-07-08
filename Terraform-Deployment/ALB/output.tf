output "blue-target_group_arn" {
  description = "ARN of the target group"
  value       = aws_lb_target_group.technova_blue_tg.arn
}

output "green-target_group_arn" {
  description = "ARN of the target group"
  value       = aws_lb_target_group.technova_green_tg.arn
}

output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.test.dns_name
}

output "listener-arns" {
  value = aws_lb_listener.Listener.arn
}

output "blue-tg-name" {
  description = "ARN of the target group"
  value       = aws_lb_target_group.technova_blue_tg.name
}

output "green-tg-name" {
  description = "ARN of the target group"
  value       = aws_lb_target_group.technova_green_tg.name
}
