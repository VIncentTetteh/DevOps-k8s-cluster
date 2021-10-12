output "cluster_name" {
  value = aws_eks_cluster.tt_k8s_cluster
}

output "region" {
  value = "us-east-2"
}

output "cluster_endpoint" {
  value = aws_eks_cluster.tt_k8s_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.tt_k8s_cluster.certificate_authority[0].data
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane."
  value       = aws_security_group.tt_k8s_sg.id
}