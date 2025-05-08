ami_id         = "ami-0d5bb3742db8fc264" # Ubuntu 20.04 in ap-northeast-2
instance_type  = "t3.micro"
subnet_id      = "subnet-019f43696c656abef"
vpc_id         = "vpc-02a36fe480ecccb85"
key_name = "openwebui-key"
instance_name  = "openwebui-llm"
docker_compose_content = "base64로_인코딩된_docker-compose.yml_내용"
env_file_content = "여기에_base64_인코딩된_.env_내용"


