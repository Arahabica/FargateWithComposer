#!/bin/sh

CLUSTER_NAME=test-express-2
TARGET_GROUP=arn:aws:elasticloadbalancing:ap-northeast-1:636061485504:targetgroup/test-express-2/c907652a63f8fe5c
PROJECT_NAME=test-express-2

AWS_ACCOUNT_ID=636061485504
AWS_REGION=ap-northeast-1

bash ./scripts/push.sh test-express-2-express nginx ${AWS_ACCOUNT_ID} ${AWS_REGION}
bash ./scripts/push.sh test-express-2 . ${AWS_ACCOUNT_ID} ${AWS_REGION}

echo "AWS_ACCOUNT_ID=$AWS_ACCOUNT_ID" > .env
echo "AWS_REGION=$AWS_REGION" > .env

ecs-cli compose \
  --file docker-compose.yml \
  --ecs-params ecs-param.yml \
  --project-name ${PROJECT_NAME} \
  --cluster ${CLUSTER_NAME} \
  service up --launch-type FARGATE \
  --container-name web \
  --container-port 80 \
  --target-group-arn ${TARGET_GROUP}