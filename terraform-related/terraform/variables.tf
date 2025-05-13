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


variable "eks_cluster_name" {
  description = "EKS 클러스터 이름"
  type        = string
}

variable "eks_node_group_name" {
  description = "EKS 노드 그룹 이름"
  type        = string
}

variable "eks_node_instance_type" {
  description = "EKS 워커 노드 인스턴스 타입"
  type        = string
}

variable "eks_desired_capacity" {
  description = "EKS 노드 desired 개수"
  type        = number
}

variable "eks_min_size" {
  description = "EKS 노드 최소 개수"
  type        = number
}

variable "eks_max_size" {
  description = "EKS 노드 최대 개수"
  type        = number
}

variable "eks_subnet_ids" {
  description = "EKS가 배포될 서브넷 ID 목록"
  type        = list(string)
}

variable "eks_vpc_id" {
  description = "EKS 클러스터 VPC ID"
  type        = string
}
