output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "List of public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of private subnets"
  value       = module.vpc.private_subnets
}

output "alb_dns_name" {
  description = "Public DNS of the Application Load Balancer"
  value       = aws_lb.app.dns_name
}

output "rds_endpoint" {
  description = "PostgreSQL RDS endpoint"
  value       = aws_db_instance.postgres.address
}