data "kubernetes_ingress_v1" "alb" {
  metadata {
    name      = var.app_name
    namespace = var.app_namespace
  }

  depends_on = [
    module.alb
  ]
}
