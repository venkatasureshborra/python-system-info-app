variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_role_arn" {
  description = "IAM role ARN for EKS control plane"
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs for EKS control plane"
  type        = list(string)
}

variable "kubernetes_version" {
  description = "Kubernetes version for EKS"
  type        = string
  default     = "1.34"
}

variable "endpoint_private_access" {
  description = "Enable private EKS API endpoint"
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Enable public EKS API endpoint"
  type        = bool
  default     = true
}

variable "enabled_cluster_log_types" {
  description = "Control plane log types"
  type        = list(string)
  default = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]
}
