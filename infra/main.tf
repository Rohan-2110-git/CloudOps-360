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
