variable "aws_region" {
  description = "AWS 리전"
  type        = string
  default     = "ap-northeast-2"
}

variable "cluster_name" {
  description = "EKS 클러스터 이름"
  type        = string
}

variable "env_file_content" {
  description = "Base64 인코딩된 .env 파일 내용 (Kubernetes Secret 용)"
  type        = string
  sensitive   = true
}

variable "litellm_config_content" {
  description = "Base64 인코딩된 litellm_config.yaml 내용"
  type        = string
  sensitive   = true
}

variable "prometheus_config_content" {
  description = "Base64 인코딩된 prometheus.yml 내용"
  type        = string
  sensitive   = true
}
