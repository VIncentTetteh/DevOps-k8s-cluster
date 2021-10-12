resource "aws_eks_cluster" "tt_k8s_cluster" {
  name     = "tt_k8s_cluster"
  role_arn = aws_iam_role.tt_cluster_iam_role.arn

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true
    subnet_ids = [
      aws_subnet.public.id,
      aws_subnet.private_1.id,
      aws_subnet.private_2.id,
    ]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.tt-AmazonEKSClusterPolicy,
  ]
}

resource "aws_iam_role" "tt_cluster_iam_role" {
  name = "tt_cluster_iam_role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "tt-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.tt_cluster_iam_role.name
}