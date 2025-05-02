FROM python:3.10-slim

# 시스템 패키지 설치
RUN apt-get update && apt-get install -y curl gnupg build-essential

# Node.js 설치 (Prisma CLI에 필요)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# Python 패키지 설치
RUN pip install --no-cache-dir litellm[proxy] prisma

# Prisma 스키마 복사 및 설정
COPY prisma /app/prisma
COPY .env /app/.env
ENV DATABASE_URL="postgresql://neondb_owner:npg_mg5lPRpoB0IL@ep-small-poetry-a51xtci9-pooler.us-east-2.aws.neon.tech/neondb?sslmode=require"
WORKDIR /app/prisma
# Prisma generate + DB push
RUN prisma generate && prisma db push --accept-data-loss

# 앱 설정
WORKDIR /app
COPY litellm.config.yaml /app/config.yaml
ENV LITELLM_CONFIG_PATH=/app/config.yaml

CMD ["litellm", "--config", "/app/config.yaml"]

