resource "aws_eks_node_group" "tt_k8s_node_group" {
  cluster_name         = aws_eks_cluster.tt_k8s_cluster.name
  node_group_name      = "tt_k8s_node_group"
  node_role_arn        = aws_iam_role.tt_node_group_role.arn
  ami_type             = "AL2_x86_64"
  instance_types       = ["t3.small"]
  capacity_type        = "ON_DEMAND"
  force_update_version = false

  disk_size = 80
  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

  labels = {
    "role" = "tt_k8s_node_group"
  }

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.tt-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.tt-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.tt-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_iam_role" "tt_node_group_role" {
  name = "tt_node_group_role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "tt-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.tt_node_group_role.name
}

resource "aws_iam_role_policy_attachment" "tt-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.tt_node_group_role.name
}

resource "aws_iam_role_policy_attachment" "tt-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.tt_node_group_role.name
}

