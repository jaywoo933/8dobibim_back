ami_id         = "ami-0d5bb3742db8fc264" # AWS EC2용 Ubuntu 20.04 AMI (리전: ap-northeast-2)
instance_type  = "t3.medium"             # EC2 인스턴스 타입 (RAM/CPU 성능 확보를 위해 t3.medium 선택)
subnet_id      = "subnet-019f43696c656abef" # 배포할 서브넷 ID
vpc_id         = "vpc-02a36fe480ecccb85"    # EC2 인스턴스가 속할 VPC ID
key_name       = "openwebui-key"            # SSH 접속을 위한 키페어 이름
instance_name  = "openwebui-llm"            # EC2 인스턴스의 Name 태그 값

# docker-compose.yml 전체 내용을 base64로 인코딩한 값
# -> Terraform에서 startup.sh.tpl로 전달됨 (멀티라인 YAML 대응)
docker_compose_content = "dmVyc2lvbjogJzMuOCcKCnNlcnZpY2VzOgogICMjIyMj..."  # (생략됨)
