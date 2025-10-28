variable "cluster_name" {
  description = "ECS cluster name"
  type        = string
}

variable "service_name" {
  description = "ECS service name"
  type        = string
}

variable "image" {
  description = "Container image (ECR URI:tag)"
  type        = string
}

variable "container_port" {
  description = "App container port"
  type        = number
  default     = 5000
}

variable "cpu" {
  description = "Fargate task CPU units"
  type        = number
  default     = 256
}

variable "memory" {
  description = "Fargate task memory (MB)"
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Initial number of tasks"
  type        = number
  default     = 1
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for ALB"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for ECS tasks"
  type        = list(string)
  default     = []
}

variable "assign_public_ip" {
  description = "Assign public IP to tasks"
  type        = bool
  default     = true
}

variable "log_group_name" {
  description = "CloudWatch Logs group for ECS task"
  type        = string
  default     = "/ecs/cloudops360-backend"
}

variable "aws_region" {
  description = "Region for AWS logs driver"
  type        = string
  default     = "ap-south-1"
}

variable "min_capacity" {
  description = "Minimum ECS task count"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum ECS task count"
  type        = number
  default     = 2
}

variable "target_cpu" {
  description = "Target CPU utilization percentage for scaling"
  type        = number
  default     = 50
}
