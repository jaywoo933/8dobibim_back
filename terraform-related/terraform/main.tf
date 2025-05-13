#terraform-related/terraform/main.tf
# main.tf (EKS 클러스터 기반)
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

# EKS 클러스터 정보 가져오기
data "aws_eks_cluster" "eks" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "eks" {
  name = var.cluster_name
}

# Kubernetes Provider 설정 (EKS 클러스터 연동)
provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}

# Helm Provider 설정 (Grafana, Loki 등 설치 가능)
provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}

# 예: kubectl로 YAML 직접 적용
resource "null_resource" "apply_k8s_manifests" {
  provisioner "local-exec" {
    command = "kubectl apply -f ../kubernetes/manifests/"
  }

  depends_on = [data.aws_eks_cluster.eks]
}

# .env → Secret
resource "kubernetes_secret" "litellm_env" {
  metadata {
    name = "litellm-env"
  }

  data = {
    ".env" = base64decode(var.env_file_content)
  }

  type = "Opaque"
}

# litellm_config.yaml → ConfigMap
resource "kubernetes_config_map" "litellm_config" {
  metadata {
    name = "litellm-config"
  }

  data = {
    "config.yaml" = base64decode(var.litellm_config_content)
  }
}

# prometheus.yml → ConfigMap
resource "kubernetes_config_map" "prometheus_config" {
  metadata {
    name = "prometheus-config"
  }

  data = {
    "prometheus.yml" = base64decode(var.prometheus_config_content)
  }
}

# YAML 적용 순서를 보장하기 위한 depends_on 수정
resource "null_resource" "apply_k8s_manifests" {
  provisioner "local-exec" {
    command = "kubectl apply -f ../kubernetes/manifests/"
  }

  depends_on = [
    kubernetes_secret.litellm_env,
    kubernetes_config_map.litellm_config,
    kubernetes_config_map.prometheus_config,
    data.aws_eks_cluster.eks
  ]
}
