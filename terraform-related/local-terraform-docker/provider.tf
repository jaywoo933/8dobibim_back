# provider.tf 파일 내용

terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 2.15.0" # 설치된 docker desktop 버전에 따라 다를 수 있지만, 보통 이 버전으로 충분
    }
  }
}

provider "docker" {} # 로컬 Docker 데몬 사용 시 설정 필요 없음