# 기존 IAM Role 참조
data "aws_iam_role" "eks_node_role" {
  name = "eks-node-role"
}

# Node Group
resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = var.eks_node_group_name
  node_role_arn   = data.aws_iam_role.eks_node_role.arn
  subnet_ids      = var.eks_subnet_ids

  scaling_config {
    desired_size = var.eks_desired_capacity
    max_size     = var.eks_max_size
    min_size     = var.eks_min_size
  }

  instance_types = [var.eks_node_instance_type]
}
