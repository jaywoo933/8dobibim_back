# AWS 리전 설정 (기본값: 서울 리전)
variable "aws_region" {
  type        = string
  default     = "ap-northeast-2"
}

# EKS 클러스터 이름
variable "cluster_name" {
  type        = string
  description = "EKS 클러스터 이름"
}

# EKS 노드 그룹 이름
variable "eks_node_group_name" {
  type = string
}

# EC2 인스턴스 타입 (예: t3.medium)
variable "eks_node_instance_type" {
  type = string
}

# 오토스케일링: 원하는 파드 수
variable "eks_desired_capacity" {
  type = number
}

# 오토스케일링: 최소 파드 수
variable "eks_min_size" {
  type = number
}

# 오토스케일링: 최대 파드 수
variable "eks_max_size" {
  type = number
}

# 사용할 VPC ID (EKS 클러스터가 배치될 VPC)
variable "eks_vpc_id" {
  type = string
}

# 사용할 서브넷 목록 (EKS 노드 및 컨트롤 플레인용)
variable "eks_subnet_ids" {
  type = list(string)
}

# -------------------- 추가 변수 --------------------

# .env 파일의 내용 (base64 인코딩된 문자열)
# 예: OPENAI_API_KEY, DATABASE_URL 등 민감 정보 포함
variable "env_file_content" {
  type        = string
  description = ".env 파일 내용 (base64 인코딩)"
  sensitive   = true  # 터미널 출력 방지
}

# Prometheus 설정 파일 (prometheus.yml) base64 인코딩된 문자열
variable "prometheus_config_content" {
  type        = string
  description = "prometheus 설정 파일 내용 (base64 인코딩)"
  sensitive   = true
}

# litellm_config.yaml 내용 (base64 인코딩)
variable "litellm_config_content" {
  description = "Base64 encoded litellm_config.yaml content"
  type        = string
  default     = ""  # 필수는 아님
}

# eks_cluster_name이 위 cluster_name과 중복될 경우도 있으므로 따로 사용 가능
variable "eks_cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "openwebui"
}
