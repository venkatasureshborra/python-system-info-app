variable "region" {
  description = "AWS region for EKS"
}

variable "cluster_name" {
  description = "EKS cluster name"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
}

variable "private_subnet_count" {
  description = "Number of private subnets"
}

variable "public_subnet_count" {
  description = "Number of public subnets"
}

variable "kubernetes_version" {
  description = "Kubernetes version for EKS"
}
variable "ami_type" {
  description = "instance-ami-id"
}
variable "node_instance_types" {
  description = "Instance types for worker nodes"
  type        = list(string)
}

variable "node_desired_size" {
  description = "Desired worker nodes"
}

variable "node_min_size" {
  description = "Minimum worker nodes"
}

variable "node_max_size" {
  description = "Maximum worker nodes"
  type        = number
}

variable "app_name" {
  description = "Application name used for Kubernetes resources"
}

variable "app_namespace" {
  description = "Kubernetes namespace where the application is deployed"
}
