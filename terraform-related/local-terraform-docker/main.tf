# main.tf 파일 내용

# 우리는 실제 Docker 자원을 직접 관리하기보다
# docker-compose 명령 실행 자체를 Terraform으로 제어하고 싶습니다.
# 이를 위해 null_resource와 local-exec 프로비저너를 사용합니다.
resource "null_resource" "run_docker_compose" {
  # 이 리소스는 실제 AWS/Docker 자원을 만들지 않습니다.
  # 단지 Terraform apply/destroy 시점에 특정 동작을 트리거하기 위한 목적입니다.

  # =======================================
  # apply (생성) 시점에 실행될 명령어
  # =======================================
  provisioner "local-exec" {
    # command는 실행할 명령어입니다.
    # "docker-compose up -d" 명령어를 실행합니다.
    # -d 옵션은 백그라운드로 실행하라는 뜻입니다.
    command = "docker-compose up -d"

    # working_dir는 명령어를 실행할 디렉토리를 지정합니다.
    # docker-compose.yml 파일이 있는 폴더 경로를 넣어주세요.
    # 여러분의 TEST/multi_contain 폴더 경로에 맞게 수정하세요!
    working_dir = "../../docker-related/"

    # (선택 사항) 명령 실행 실패 시 Terraform 적용 중단
    on_failure = fail

    # 이 프로비저너는 리소스가 "생성될 때" (terraform apply) 실행됩니다.
    when = create
  }

  # =======================================
  # destroy (파괴) 시점에 실행될 명령어
  # =======================================
  provisioner "local-exec" {
    # command는 실행할 명령어입니다.
    # "docker-compose down" 명령어를 실행하여 컨테이너를 종료하고 네트워크 등을 정리합니다.
    command = "docker-compose down"

    # working_dir는 명령어를 실행할 디렉토리를 지정합니다.
    # docker-compose.yml 파일이 있는 폴더 경로를 넣어주세요.
    # 여러분의 TEST/multi-container 폴더 경로에 맞게 수정하세요!
    working_dir = "../../docker-related/" 

    # 이 프로비저너는 리소스가 "파괴될 때" (terraform destroy) 실행됩니다.
    when = destroy
  }

  # =======================================
  # 추가 설정 (변경 감지를 위해)
  # =======================================
  # null_resource는 기본적으로 항상 "변경 없음"으로 감지됩니다.
  # 하지만 local-exec을 사용할 때는 명령어 자체나 작업 디렉토리 등이 바뀌면
  # 리소스가 "변경됨"으로 감지되어 provisioner가 다시 실행되도록 하는 것이 유용합니다.
  # triggers 설정을 통해 특정 값이 변경될 때 이 리소스가 변경된 것으로 간주하도록 합니다.
  triggers = {
    # docker-compose.yml 파일 내용의 해시값
    # 파일 내용이 변경되면 이 값도 바뀌므로, null_resource가 변경된 것으로 감지됩니다.
    docker_compose_config_hash = filebase64sha256("../../docker-related/docker-compose.yml")

    # .env 파일 내용의 해시값 (필요하다면 추가)
    # env_file_hash = filebase64sha256("../../docker-related/.env")

    # litellm config 파일 내용의 해시값 (필요하다면 추가)
    # litellm_config_hash = filebase64sha256("../../docker-related/litellm_config.yaml")

    # working_dir 자체의 경로가 바뀌었을 때
    working_directory_path = "../../docker-related/" # 실제 working_dir 경로
  }
}