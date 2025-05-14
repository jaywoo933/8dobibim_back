#main.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# 기존 Role 참조 (이미 AWS 콘솔에 존재한다고 가정)
data "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"
}

# 클러스터 정의
resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = data.aws_iam_role.eks_cluster_role.arn
  version  = "1.29"

  vpc_config {
    subnet_ids = var.eks_subnet_ids
  }

  depends_on = [] # role 생성이 아니므로 depends_on 제거
}
