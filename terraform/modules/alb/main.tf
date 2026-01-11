resource "helm_release" "alb_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"

  values = [
    templatefile("${path.module}/values.yaml", {
      cluster_name = var.cluster_name
      region       = var.region
      vpc_id       = var.vpc_id
      role_arn     = aws_iam_role.alb_controller.arn
    })
  ]

  depends_on = [
    aws_iam_role_policy_attachment.alb_attach
  ]
}
