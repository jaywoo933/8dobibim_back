# 생성된 EKS 클러스터의 이름을 출력
# terraform apply 완료 후 터미널에 출력되어, 클러스터 이름을 쉽게 확인가능.
output "cluster_name" {
  value = aws_eks_cluster.eks.name # EKS 클러스터 리소스에서 name 속성 값을 가져옴
}
