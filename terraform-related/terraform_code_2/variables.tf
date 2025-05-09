# AWS 리전 (기본값: 서울 리전)
variable "aws_region" {
  description = "AWS 리전"
  type        = string
  default     = "ap-northeast-2"
}

# EC2 인스턴스 생성에 사용할 AMI ID (예: Ubuntu 20.04)
variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

# EC2 인스턴스에서 사용할 인스턴스 타입 (기본값: t3.micro)
variable "instance_type" {
  description = "EC2 인스턴스 타입"
  type        = string
  default     = "t3.micro"
}

# 배포할 서브넷 ID
variable "subnet_id" {
  description = "서브넷 ID"
  type        = string
}

# 배포할 VPC ID
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

# EC2 인스턴스에 연결할 SSH 키페어 이름
variable "key_name" {
  description = "SSH 키 페어 이름"
  type        = string
}

# EC2 인스턴스에 부여할 Name 태그
variable "instance_name" {
  description = "EC2 인스턴스 이름"
  type        = string
}

# Open WebUI가 사용할 포트 번호 (기본: 8080)
variable "openwebui_port" {
  description = "OpenWebUI 포트"
  type        = number
  default     = 8080
}

# docker-compose.yml의 내용을 base64로 인코딩하여 전달 (민감한 설정 포함 가능)
variable "docker_compose_content" {
  description = "Base64 인코딩된 docker-compose.yml 내용"
  type        = string
  sensitive   = true
}

# .env 환경설정 파일 내용 (base64 인코딩)
variable "env_file_content" {
  description = "Base64 인코딩된 .env 파일 내용"
  type        = string
  sensitive   = true
}

# litellm_config.yaml 설정 내용 (멀티라인 YAML, base64 디코딩 후 사용)
variable "litellm_config_content" {
  description = "Base64 decoded content for litellm_config.yaml"
}

# prometheus.yml 설정 내용 (base64 디코딩 후 사용)
variable "prometheus_config_content" {
  description = "Base64 decoded content for prometheus.yml"
}
