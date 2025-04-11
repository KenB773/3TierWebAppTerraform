 resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Allow ECS to access RDS"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "postgres" {
  name       = "postgres-db-subnet-group"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = "Postgres subnet group"
  }
}

resource "aws_db_instance" "postgres" {
  identifier              = "postgres-${var.project}"
  allocated_storage       = 20
  engine                  = "postgres"
#  engine_version          = "15.3"
  instance_class          = "db.t3.micro"
  db_name                 = "appdb"
  username                = var.db_username
  password                = var.db_password
  publicly_accessible     = false
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.postgres.name
}
