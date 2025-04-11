# Security group for ECS tasks
resource "aws_security_group" "ecs_sg" {
  name        = "ecs_sg"
  description = "Allow ECS tasks to access RDS"
  vpc_id      = module.vpc.vpc_id

  # Allow outbound traffic to RDS (Postgres)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security group for RDS instance
