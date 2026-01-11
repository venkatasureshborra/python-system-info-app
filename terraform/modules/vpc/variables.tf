variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "private_subnet_count" {
  description = "Number of private subnets (AZs)"
  type        = number
}

variable "public_subnet_count" {
  description = "Number of public subnets (AZs)"
  type        = number
  default     = 2
}

variable "cluster_name" {
  description = "EKS cluster name for tagging"
  type        = string
}