variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

# Required for ECS image deployment
variable "backend_image" {
  description = "Full image URI for backend container"
  type        = string
}
