# VPC 모듈: VPC + 서브넷 자동 생성
# 공식 모듈 사용: https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"  # Terraform 공식 AWS VPC 모듈 소스
  version = "5.1.1"  # 사용할 모듈 버전 지정

  name = "eks-vpc"   # VPC 이름 prefix
  cidr = "10.0.0.0/16" # 전체 VPC의 IP 대역 (CIDR 블록)
                       # 퍼블릭 서브넷 IP 대역 2개
  azs             = ["ap-northeast-2a", "ap-northeast-2c"] # 서울 리전 내에서 2개 지정
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]# 퍼블릭 서브넷 IP 대역 2개    # 각각 azs[0], azs[1]에 매핑됨
  private_subnets = ["10.0.11.0/24", "10.0.12.0/24"]

  enable_nat_gateway = true # NAT 게이트웨이 생성 여부 (Private 서브넷이 인터넷에 나갈 수 있도록)
  single_nat_gateway = true # NAT 게이트웨이 하나만 생성해서 비용 절감


  tags = { # 생성되는 모든 리소스에 공통으로 붙는 태그
    Name = "eks-vpc"
  }
}

#EKS 클러스터 생성
resource "aws_eks_cluster" "eks" {
  name     = var.cluster_name  # EKS 클러스터 이름 (variables.tf에서 정의된 변수 참조)
  role_arn = aws_iam_role.eks_role.arn  # EKS 클러스터가 사용할 IAM 역할의 ARN

  vpc_config {
    subnet_ids = module.vpc.public_subnets  # VPC 모듈에서 생성된 subnet 리스트 사용
  }

  depends_on = [aws_iam_role_policy_attachment.eks_policy_attach]
  # IAM 역할이 EKS 클러스터보다 먼저 생성되고 정책이 붙은 후 클러스터 생성되도록 순서 강제
}

# EKS 클러스터가 사용할 IAM Role 정의
resource "aws_iam_role" "eks_role" {
  name = "eks-role" # IAM 역할 이름

   # 해당 역할을 eks.amazonaws.com 서비스가 사용할 수 있도록 설정
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Principal = {
        Service = "eks.amazonaws.com"
      }
      Effect = "Allow"
      Sid    = ""
    }]
  })
}

# 위에서 정의한 IAM 역할에 EKS 전용 정책을 붙이는 리소스
resource "aws_iam_role_policy_attachment" "eks_policy_attach" {
  role       = aws_iam_role.eks_role.name # 위에서 정의한 eks-role과 연결
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy" # AWS에서 제공하는 EKS용 정책
}



