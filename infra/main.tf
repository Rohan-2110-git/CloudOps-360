/*
  CloudOps-360 — Terraform entry point
  Uses the VPC module (public-only initial setup, budget-friendly).
*/

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  # pick first two AZ names in the selected region (account-specific letters)
  azs = slice(data.aws_availability_zones.available.names, 0, 2)
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  azs                 = local.azs
}

# ECR repository for backend service image
module "ecr_backend" {
  source = "./modules/ecr"
  name   = "cloudops360-backend"
}

# ECS Fargate service behind an ALB
module "ecs_backend" {
  aws_region        = var.aws_region
  source            = "./modules/ecs"
  cluster_name      = "cloudops360-cluster"
  service_name      = "cloudops360-backend-svc"
  image             = var.backend_image
  container_port    = 5000
  desired_count     = 1
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids

  # No private subnets yet → budget friendly
  private_subnet_ids = []
  assign_public_ip   = true
}

output "alb_dns_name" {
  value = module.ecs_backend.alb_dns_name
}

output "alb_url" {
  value = "http://${module.ecs_backend.alb_dns_name}"
}
