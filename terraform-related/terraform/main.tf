#terraform-related/terraform/main.tf
# EC2 인스턴스 생성 리소스 정의
resource "aws_instance" "docker_host" {
  ami                    = var.ami_id               # 사용할 Amazon Machine Image ID (예: Ubuntu 20.04)
  instance_type          = var.instance_type        # EC2 인스턴스 타입 (예: t3.medium)
  subnet_id              = var.subnet_id            # 인스턴스가 속할 서브넷 ID
  key_name               = var.key_name             # SSH 접속용 키 페어 이름
  vpc_security_group_ids = [aws_security_group.allow_openwebui.id]  # 연결할 보안 그룹 ID

  # 루트 볼륨 설정 (디스크 크기 및 타입)
  root_block_device {
    volume_size = 30         # 루트 디스크 용량 (GB)
    volume_type = "gp3"      # 디스크 타입 (비용 효율성과 성능이 좋은 gp3 선택)
  }

  # EC2에 전달할 사용자 스크립트 (cloud-init)
  # startup.sh.tpl 파일에 환경변수 삽입 후 base64 인코딩하여 전달
  user_data = base64encode(templatefile("${path.module}/startup.sh.tpl", {
    env_file_content           = var.env_file_content,          # .env 내용 (base64)
    docker_compose_content     = var.docker_compose_content,    # docker-compose.yml 내용
    litellm_config_content     = var.litellm_config_content,    # litellm 설정
    prometheus_config_content  = var.prometheus_config_content  # prometheus 설정
  }))

  # 인스턴스 이름 태그 (콘솔에서 구분하기 쉬움)
  tags = {
    Name = var.instance_name
  }
}

# EC2 인스턴스에 접근 가능한 보안 그룹 정의
resource "aws_security_group" "allow_openwebui" {
  name        = "${var.instance_name}-sg"           # 보안 그룹 이름
  description = "Allow OpenWebUI access"            # 보안 그룹 설명
  vpc_id      = var.vpc_id                          # 속할 VPC ID

  # 인바운드 규칙 (외부에서 EC2로 접근 허용)
  ingress {
    from_port   = var.openwebui_port                # 허용 시작 포트 (예: 8080)
    to_port     = var.openwebui_port                # 허용 끝 포트 (같으면 단일 포트)
    protocol    = "tcp"                             # TCP 프로토콜 허용
    cidr_blocks = ["0.0.0.0/0"]                      # 모든 IP에서 접근 허용 (실습 환경용)
  }

  # 아웃바운드 규칙 (EC2에서 외부로 나가는 트래픽 전부 허용)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"                              # 모든 프로토콜 허용
    cidr_blocks = ["0.0.0.0/0"]
  }
}
