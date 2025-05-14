# 기존 IAM Role 참조
# 이 Role은 EC2 인스턴스에 연결되어 EKS 노드로 동작할 수 있게 함
data "aws_iam_role" "eks_node_role" {
  name = "eks-node-role"  # AWS 콘솔에서 미리 생성한 EC2용 IAM Role 이름
}

# EKS 노드 그룹 생성
resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name  # 위에서 만든 EKS 클러스터 이름과 연결
  node_group_name = var.eks_node_group_name    # 노드 그룹 이름 (변수로 입력)
  node_role_arn   = data.aws_iam_role.eks_node_role.arn  # EC2 노드가 사용할 Role의 ARN
  subnet_ids      = var.eks_subnet_ids         # 노드가 배치될 서브넷들

  scaling_config {
    desired_size = var.eks_desired_capacity  # 기본 노드 수
    max_size     = var.eks_max_size          # 최대 노드 수 (오토스케일 범위 상한)
    min_size     = var.eks_min_size          # 최소 노드 수 (오토스케일 범위 하한)
  }

  instance_types = [var.eks_node_instance_type]  # 사용할 EC2 인스턴스 타입 (예: t3.medium)
}
