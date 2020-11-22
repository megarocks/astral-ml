#!/usr/bin/env bash
set -e

AWS_ACCOUNT_ID="729331206550"
AWS_REGION="us-east-1"
PROFILE="default"
IMAGE_REPO_NAME="ru-gpt"
ECR_REPO="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"

aws ecr get-login-password \
  --region $AWS_REGION \
  --profile $PROFILE | docker login --username AWS --password-stdin $ECR_REPO

docker build -t $ECR_REPO:latest .
docker push $ECR_REPO:latest