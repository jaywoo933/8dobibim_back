

#!/bin/bash
set -e

sudo apt-get update
sudo apt-get install -y docker.io docker-compose git coreutils

sudo usermod -aG docker ubuntu
newgrp docker || true

mkdir -p /opt/openwebui
cd /opt/openwebui

echo "<<env_file_content>>" | base64 -d > .env
echo "<<docker_compose_content>>" | base64 -d > docker-compose.yml

docker-compose up -d
