#!/bin/sh

CLUSTER_NAME=test-express-2
TARGET_GROUP=arn:aws:elasticloadbalancing:ap-northeast-1:636069999999:targetgroup/test-express-2/c907652a63f8fe5c
PROJECT_NAME=test-express-2

AWS_ACCOUNT_ID=63609999999
AWS_REGION=ap-northeast-1

EXPRESS_REPO=test-express-2-express
NGINX_REPO=test-express-2-nginx

bash ./scripts/push.sh ${EXPRESS_REPO} . ${AWS_ACCOUNT_ID} ${AWS_REGION}
bash ./scripts/push.sh ${NGINX_REPO} ./nginx ${AWS_ACCOUNT_ID} ${AWS_REGION}

echo "AWS_ACCOUNT_ID=$AWS_ACCOUNT_ID" > .env
echo "AWS_REGION=$AWS_REGION" >> .env
echo "EXPRESS_REPO=$EXPRESS_REPO" >> .env
echo "NGINX_REPO=$NGINX_REPO" >> .env

aws ecs create-cluster --cluster-name ${CLUSTER_NAME}

`aws ecr get-login --no-include-email`


ecs-cli compose \
  --file docker-compose.yml \
  --ecs-params ecs-param.yml \
  --project-name ${PROJECT_NAME} \
  --cluster ${CLUSTER_NAME} \
  service up --launch-type FARGATE \
  --container-name nginx \
  --container-port 80 \
  --target-group-arn ${TARGET_GROUP}
