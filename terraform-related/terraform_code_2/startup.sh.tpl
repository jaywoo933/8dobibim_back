#!/bin/bash
set -e

# 패키지 목록 업데이트 및 필수 패키지 설치
sudo apt-get update
sudo apt-get install -y docker.io docker-compose git coreutils

# 현재 사용자를 docker 그룹에 추가 (sudo 없이 docker 사용 가능하게)
sudo usermod -aG docker ubuntu

# 재부팅 없이 그룹 변경 적용 시도 (실패해도 무시)
newgrp docker || true

# 작업 디렉토리 생성 및 이동
mkdir -p /opt/openwebui
cd /opt/openwebui

# 환경 변수 저장 (.env 또는 export 필요시)
echo "OPENAI_API_KEY=${openai_api_key}" > .env

# Base64로 인코딩된 docker-compose.yml 내용 디코딩 후 저장
echo "${docker_compose_content}" | base64 -d > docker-compose.yml

# Docker Compose 실행
docker-compose up -d
