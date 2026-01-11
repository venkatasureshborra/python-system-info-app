module "vpc" {
  source               = "./modules/vpc"
  cluster_name         = var.cluster_name
  vpc_cidr             = var.vpc_cidr
  private_subnet_count = var.private_subnet_count
  public_subnet_count  = var.public_subnet_count
}

module "security_groups" {
  source       = "./modules/security-groups"
  vpc_id       = module.vpc.vpc_id
  cluster_name = var.cluster_name
}

module "iam" {
  source       = "./modules/iam"
  cluster_name = var.cluster_name
}

module "eks" {
  source                  = "./modules/eks"
  cluster_name            = var.cluster_name
  cluster_role_arn        = module.iam.cluster_role_arn
  subnet_ids              = module.vpc.private_subnet_ids
  kubernetes_version      = var.kubernetes_version
  endpoint_private_access = true
  endpoint_public_access  = true
}

module "nodegroup" {
  source          = "./modules/nodegroup"
  cluster_name    = module.eks.cluster_name
  subnet_ids      = module.vpc.private_subnet_ids
  worker_role_arn = module.iam.worker_role_arn

  ami_type               = var.ami_type
  instance_types         = var.node_instance_types
  desired_size           = var.node_desired_size
  min_size               = var.node_min_size
  max_size               = var.node_max_size
  node_security_group_id = module.security_groups.node_sg_id

}

module "alb" {
  source            = "./modules/alb"
  cluster_name      = module.eks.cluster_name
  region            = var.region
  vpc_id            = module.vpc.vpc_id
  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_provider_url = module.eks.oidc_provider_url

  depends_on = [
    module.eks,
    module.nodegroup
  ]
}


