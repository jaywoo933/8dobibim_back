#변수 선언 및 기본 값 설정 파일
#main.tf등 다른 파일에서 var.cluster_name으로 참조됨
#생성될 EKS 클러스터의 이름을 지정하는데 사용됨
variable "cluster_name" {
  default = "my-eks-cluster"
}

#aws 리전 정의 변수
#provider 설정 또는 리소스 블록 등에서 var.region으로 참조됨
variable "region" {
  default = "ap-northeast-2"
}
