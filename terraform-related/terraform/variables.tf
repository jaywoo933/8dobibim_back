variable "aws_region" {
  type        = string
  default     = "ap-northeast-2"
}

variable "cluster_name" {
  type        = string
  description = "EKS 클러스터 이름"
}

variable "eks_node_group_name" {
  type = string
}

variable "eks_node_instance_type" {
  type = string
}

variable "eks_desired_capacity" {
  type = number
}

variable "eks_min_size" {
  type = number
}

variable "eks_max_size" {
  type = number
}

variable "eks_vpc_id" {
  type = string
}

variable "eks_subnet_ids" {
  type = list(string)
}
