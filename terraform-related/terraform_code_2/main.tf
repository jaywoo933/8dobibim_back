resource "aws_instance" "docker_host" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_openwebui.id]
  
  root_block_device {
    volume_size = 30         # 디스크 용량 (GB)
    volume_type = "gp3"      # 보통 gp3 사용 (성능/비용 측면에서 좋음)
  }
 user_data = base64encode(templatefile("${path.module}/startup.sh.tpl", {
  env_file_content           = var.env_file_content,
  docker_compose_content     = var.docker_compose_content,
  litellm_config_content     = var.litellm_config_content,      
  prometheus_config_content  = var.prometheus_config_content     
}))


  tags = {
    Name = var.instance_name
  }
}

resource "aws_security_group" "allow_openwebui" {
  name        = "${var.instance_name}-sg"
  description = "Allow OpenWebUI access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.openwebui_port
    to_port     = var.openwebui_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
