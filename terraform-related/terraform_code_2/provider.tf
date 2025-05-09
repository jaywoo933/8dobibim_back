# terraform-related/terraform_code_2/provider.tf

# Terraform에서 사용할 프로바이더 정의
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"         # AWS 프로바이더 공식 경로
      version = "~> 4.0"                # GitHub Actions에서도 안정적으로 동작하는 4.x 버전 권장
    }
    docker = {
      source  = "kreuzwerker/docker"    # Docker 관련 Terraform 리소스를 위해 사용
      version = "~> 2.15.0"
    }
  }
}

# AWS 프로바이더 설정
provider "aws" {
  region = var.aws_region              # 리소스를 생성할 AWS 리전 (예: ap-northeast-2)

  # 로컬 환경에서 사용할 경우
  # profile = var.aws_profile          # ~/.aws/credentials의 프로파일명

  # GitHub Actions 또는 CI/CD 환경에서는 아래 환경 변수 방식 사용
  # AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY는 GitHub Secrets로 전달됨
}

# Docker 프로바이더 설정 (로컬 Docker나 Docker Host를 제어할 때 사용 가능)
# 현재 프로젝트에서는 직접 Docker 리소스를 Terraform으로 제어하지 않으므로 실질적 사용은 없음
provider "docker" {}
