output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}
output "cluster_endpoint" {
  description = "EKS API server endpoint"
  value       = module.eks.cluster_endpoint
}
output "node_group_name" {
  description = "EKS node group name"
  value       = module.nodegroup.node_group_name
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "alb_access_url" {
  description = "Public ALB DNS name to access the application"
  value = try(
    data.kubernetes_ingress_v1.alb.status[0].load_balancer[0].ingress[0].hostname,
    null
  )
}

output "aws_region" {
  value = var.region
}