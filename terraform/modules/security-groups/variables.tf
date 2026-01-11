variable "vpc_id" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "app_port" {
  type    = number
  default = 80
}
