
# ECS Fargate service behind an ALB
module "ecs_backend" {
  source = "./modules/ecs"

  cluster_name       = "cloudops360-cluster"
  service_name       = "cloudops360-backend-svc"
  image              = var.backend_image
  container_port     = 5000
  desired_count      = 1
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = []   # not using private subnets yet
  assign_public_ip   = true # run tasks in public subnets for budget
}

output "alb_dns_name" {
  value = module.ecs_backend.alb_dns_name
}

output "alb_url" {
  value = "http://${module.ecs_backend.alb_dns_name}"
}
