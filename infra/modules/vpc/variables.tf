variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets (use 2 for two AZs)"
  type        = list(string)
}

variable "azs" {
  description = "List of availability zone names matching the subnets"
  type        = list(string)
}
