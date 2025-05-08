# main.tf
# Terraform을 사용해 AWS EC2 인스턴스를 생성하고, OpenWebUI 및 LiteLLM을 포함한 Docker Compose 서비스를 자동 실행하는 구성입니다.
# 사용자 접근을 위해 보안 그룹에서 지정된 포트를 개방합니다.

resource "aws_instance" "docker_host" {
  ami           = var.ami_id             # 사용할 AMI ID (예: Ubuntu 20.04 LTS)
  instance_type = var.instance_type      # EC2 인스턴스 타입 (예: t3.micro)
  subnet_id     = var.subnet_id          # EC2 인스턴스를 배치할 Subnet ID
  key_name      = var.key_name           # SSH 접속용 키 페어 이름

  vpc_security_group_ids = [
    aws_security_group.allow_openwebui.id
  ]                                       # 아래 정의된 Security Group을 연결

  # EC2 인스턴스 시작 시 실행될 셸 스크립트(user_data)
  # 이 스크립트는 Docker 및 Docker Compose 설치, 환경변수 설정, docker-compose.yml 생성 및 실행을 수행합니다.
  user_data = base64encode(templatefile("${path.module}/startup.sh.tpl", {
    openai_api_key           = var.openai_api_key,          # 환경변수로 전달된 OpenAI API Key
    docker_compose_content   = var.docker_compose_content   # GitHub Actions에서 전달된 docker-compose.yml 내용
  }))

  # EC2 인스턴스 태그
  tags = {
    Name = var.instance_name
  }
}

# EC2 인스턴스에서 외부 사용자 요청을 수신할 수 있도록 허용할 보안 그룹
# OpenWebUI의 기본 포트(예: 8080 등)를 개방합니다.
resource "aws_security_group" "allow_openwebui" {
  name        = "${var.instance_name}-sg"                 # 보안 그룹 이름 (인스턴스명 기반)
  description = "Allow OpenWebUI access"                  # 설명
  vpc_id      = var.vpc_id                                # 이 보안 그룹을 사용할 VPC ID

  ingress {
    from_port   = var.openwebui_port                      # 허용 시작 포트
    to_port     = var.openwebui_port                      # 허용 끝 포트 (같으면 단일 포트)
    protocol    = "tcp"                                   # TCP 프로토콜만 허용
    cidr_blocks = ["0.0.0.0/0"]                                   
    # source_security_group_id = aws_security_group.alb_sg.id
  } # 배포시 위에 방법으로 하는것이 보안상 안전
    #EC2는 외부에 직접 노출하지 않고 ALB Security group만 허용
    #ALB는 모든 기업 사용자 IP 또는 특정 IP 대역만 허용 가능

  egress {
    from_port   = 0                                       # 모든 포트 허용 (아웃바운드)
    to_port     = 0
    protocol    = "-1"                                    # 모든 프로토콜 허용
    cidr_blocks = ["0.0.0.0/0"]
  }
}
