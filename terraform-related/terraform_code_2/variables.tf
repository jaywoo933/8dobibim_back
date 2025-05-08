variable "aws_region" {
    description = "AWS 리전"
    type = string
    default = "ap-northeast-2" # 서울 리전
}

# 로컬에서만 사용하는 변수
# GitHub Actions 등 CI/CD 환경에서는 환경변수로 인증하므로 사용하지 않음
#variable "aws_profile" {
#    description = "AWS CLI 프로파일 이름"
#    type = string
#    default = "default"
#}

variable "ami_id" {
  description = "사용할 AMI ID (Ubuntu 등)"
  type        = string
}

variable "instance_type" {
  description = "EC2 인스턴스 타입 (예: t3.micro)"
  type        = string
}

variable "subnet_id" {
  description = "인스턴스를 배치할 VPC 서브넷 ID"
  type        = string
}

variable "vpc_id" {
  description = "보안 그룹을 적용할 VPC ID"
  type        = string
}

variable "key_name" {
  description = "SSH 접속용 키 페어 이름"
  type        = string
}

variable "instance_name" {
  description = "EC2 인스턴스 이름 (태그용)"
  type        = string
}

variable "openwebui_port" {
  description = "OpenWebUI가 외부에서 접근할 수 있는 포트"
  type        = number
  default     = 8080
}

variable "openai_api_key" {
  description = "OpenAI API Key (환경변수로 전달됨)"
  type        = string
  sensitive   = true
}

variable "docker_compose_content" {
  description = "docker-compose.yml 내용 (GitHub Actions에서 읽어서 전달)"
  type        = string
  sensitive   = true
}