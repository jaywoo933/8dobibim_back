# terraform-related/terraform_code_2/provider.tf

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0" # GitHub Actions 환경에 맞는 최신 안정 버전 사용 권장
    }
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 2.15.0"
    }
  }
}

provider "aws" {
    region = var.aws_region
    
    #profile = var.aws_profile, CLI로 aws configure 입력시 key 입력해야함
    #깃 액션 환경에서 ENV로 대체
    #워크플로우 추가 해야함
    #CI/CD(GitHub Actions 등)에서는 AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY 환경 변수로 인증
    #→ GitHub Secrets를 통해 전달
  
}

provider "docker" {}