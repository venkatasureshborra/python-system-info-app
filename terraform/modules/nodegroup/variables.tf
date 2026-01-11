variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "node_group_name" {
  description = "Name of the node group"
  type        = string
  default     = "prod-ng"
}

variable "subnet_ids" {
  description = "Private subnet IDs for worker nodes"
  type        = list(string)
}

variable "worker_role_arn" {
  description = "IAM role ARN for EKS worker nodes"
  type        = string
}

variable "instance_types" {
  description = "EC2 instance types for node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "capacity_type" {
  description = "ON_DEMAND or SPOT"
  type        = string
  default     = "ON_DEMAND"
}

variable "disk_size" {
  description = "Root volume size in GiB"
  type        = number
  default     = 50
}

variable "desired_size" {
  description = "Desired number of nodes"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum number of nodes"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of nodes"
  type        = number
  default     = 5
}

variable "ami_type" {
  description = "AMI type for EKS worker nodes"
  type        = string
}

variable "labels" {
  description = "Kubernetes labels for nodes"
  type        = map(string)
  default = {
    role = "worker"
  }
}

variable "taints" {
  description = "Kubernetes taints for node group"
  type = list(object({
    key    = string
    value  = string
    effect = string
  }))
  default = []
}

variable "node_security_group_id" {
  description = "Security group ID for the node group"
  type        = string
}