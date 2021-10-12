variable "region" {
  default     = "us-east-2"
  description = "AWS region"
}

variable "availability_zones" {
  default     = ["us-east-2"]
  description = "AWS availability zones"
}

variable "cluster_name" {
  default = "aws_eks_cluster.tt-k8s-cluster"
}

variable "node_group_name" {
  default = "tt-k8s-node-group"
}


variable "tt_private_networks" {
  default = ["102.176.73.186/32", "154.160.75.86/32", "192.168.128.0/24", "192.168.10.0/24"]
}