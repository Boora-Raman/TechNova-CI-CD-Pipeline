resource "aws_security_group" "allow_tls" {
  name        = "technova-allow-tls"
  description = "Allow inbound HTTP and ECS traffic, allow all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "technova-allow-tls"
  }

  ingress {
    description      = "Allow HTTP traffic from anywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

ingress {
    description      = "Allow HTTP traffic on port 3000 from anywhere"
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
}

  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
