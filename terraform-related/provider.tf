#AWS 프로바이더 설정
#Terrafrom이 사용할 클라우드 공급자 지정
#'provider "aws" 블록은 AWS에 대한 설정 정의

provider "aws" {
  region = "ap-northeast-2" #region은 서울을 의미
}
