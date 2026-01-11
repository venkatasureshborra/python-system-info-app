output "node_group_name" {
  description = "EKS node group name"
  value       = aws_eks_node_group.this.node_group_name
}

output "node_group_arn" {
  description = "EKS node group ARN"
  value       = aws_eks_node_group.this.arn
}

output "node_group_status" {
  description = "EKS node group status"
  value       = aws_eks_node_group.this.status
}
