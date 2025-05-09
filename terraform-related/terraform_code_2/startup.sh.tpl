#!/bin/bash
set -e

sudo apt-get update
sudo apt-get install -y docker.io docker-compose git coreutils

sudo usermod -aG docker ubuntu
newgrp docker || true

mkdir -p /opt/openwebui
cd /opt/openwebui

# .env 파일 저장 (base64 디코딩)
echo "${env_file_content}" | base64 -d > .env

# docker-compose.yml 저장 (base64 디코딩)
echo "${docker_compose_content}" | base64 -d > docker-compose.yml

# litellm_config.yaml 저장 (base64 디코딩)
echo "${litellm_config_content}" | base64 -d > litellm_config.yaml

# prometheus config 저장 (base64 디코딩)
mkdir -p prometheus_config
echo "${prometheus_config_content}" | base64 -d > prometheus_config/prometheus.yml

# 컨테이너 실행
docker-compose up -d
