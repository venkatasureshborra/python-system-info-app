resource "aws_eks_node_group" "this" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = var.worker_role_arn
  subnet_ids      = var.subnet_ids

  ami_type       = var.ami_type
  instance_types = var.instance_types
  capacity_type  = var.capacity_type
  disk_size      = var.disk_size

  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }

  labels = var.labels

  dynamic "taint" {
    for_each = var.taints
    content {
      key    = taint.value.key
      value  = taint.value.value
      effect = taint.value.effect
    }
  }

  update_config {
    max_unavailable = 1
  }

  tags = {
    Name        = "${var.cluster_name}-${var.node_group_name}"
    Environment = "production"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_template" "this" {
  name_prefix = "${var.cluster_name}-lt"

  network_interfaces {
    security_groups = [var.node_security_group_id]
  }
}
