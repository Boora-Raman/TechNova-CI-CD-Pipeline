resource "aws_security_group" "allow_tls" {
  name        = "strapi-allow-tls"
  description = "Allow inbound HTTP and ECS traffic, allow all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "strapi-allow-tls"
  }

  ingress {
    description      = "Allow HTTP traffic from anywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description                   = "Allow ECS traffic from ALB (port 1337)"
    from_port                     = 3000
    to_port                       = 3000
    protocol                      = "tcp"  # Replace if ALB has a separate SG
  }

  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
