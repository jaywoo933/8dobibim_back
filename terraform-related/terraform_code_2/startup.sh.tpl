#!/bin/bash
set -e

sudo apt-get update
sudo apt-get install -y docker.io docker-compose git coreutils

sudo usermod -aG docker ubuntu
newgrp docker || true

mkdir -p /opt/openwebui
cd /opt/openwebui

# .env 파일 저장 (base64 디코딩 필요)
echo "${env_file_content}" | base64 -d > .env

# docker-compose.yml 저장 (멀티라인 YAML 처리)
cat <<EOF > docker-compose.yml
${docker_compose_content}
EOF

# litellm_config.yaml 저장
cat <<EOF > litellm_config.yaml
${litellm_config_content}
EOF

# prometheus config 저장
mkdir -p prometheus_config
cat <<EOF > prometheus_config/prometheus.yml
${prometheus_config_content}
EOF

# 컨테이너 실행
docker-compose up -d
