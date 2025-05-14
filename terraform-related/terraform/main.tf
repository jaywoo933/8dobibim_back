# Terraform 설정 블록: 사용할 프로바이더 정의
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"      # AWS 프로바이더 사용
      version = "~> 4.0"             # 4.x 버전대를 사용 (최신 주요 버전)
    }
  }
}

# AWS 프로바이더 설정
provider "aws" {
  region = var.aws_region  # 사용할 리전은 변수로부터 입력 받음
}

# 이미 존재하는 IAM Role을 참조 (eks-cluster-role)
# 이 Role은 eks:CreateCluster 등 필요한 권한을 포함해야 함
data "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"  # 콘솔에 사전에 생성된 Role 이름
}

# EKS 클러스터 생성 리소스
resource "aws_eks_cluster" "this" {
  name     = var.cluster_name  # 클러스터 이름은 변수에서 받아옴
  role_arn = data.aws_iam_role.eks_cluster_role.arn  # 위에서 참조한 Role의 ARN을 사용
  version  = "1.29"  # 사용할 Kubernetes 버전

  vpc_config {
    subnet_ids = var.eks_subnet_ids  # EKS 클러스터가 사용할 서브넷 목록
    # 보통 퍼블릭 & 프라이빗 서브넷 혼합 구성이 권장됨
  }

  depends_on = []  # Role을 새로 생성하지 않기 때문에 명시적 의존성 없음
}
