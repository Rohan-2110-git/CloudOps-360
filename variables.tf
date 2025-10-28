
# ECR image for backend (e.g., 123456789012.dkr.ecr.ap-south-1.amazonaws.com/cloudops360-backend:latest)
variable "backend_image" {
  description = "Full image URI for backend container"
  type        = string
}
