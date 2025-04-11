variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "project" {
  type    = string
  default = "3tierproj-terraform"
}

variable "vpc_name" {
  type    = string
  default = "3tierproj-vpc"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "db_username" {
  type        = string
  description = "PostgreSQL username"
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "PostgreSQL password"
}

variable "container_image" {
  type        = string
  description = "Docker image URI for the application"
}
