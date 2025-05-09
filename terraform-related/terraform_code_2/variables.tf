variable "aws_region" {
  description = "AWS 리전"
  type        = string
  default     = "ap-northeast-2"
}

variable "litellm_config_content" {
  description = "Base64 decoded content for litellm_config.yaml"
}

variable "prometheus_config_content" {
  description = "Base64 decoded content for prometheus.yml"
}

variable "instance_type" {
  description = "EC2 인스턴스 타입"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "서브넷 ID"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "key_name" {
  description = "SSH 키 페어 이름"
  type        = string
}

variable "instance_name" {
  description = "EC2 인스턴스 이름"
  type        = string
}

variable "openwebui_port" {
  description = "OpenWebUI 포트"
  type        = number
  default     = 8080
}

variable "docker_compose_content" {
  description = "Base64 인코딩된 docker-compose.yml 내용"
  type        = string
  sensitive   = true
}

variable "env_file_content" {
  description = "Base64 인코딩된 .env 파일 내용"
  type        = string
  sensitive   = true
}