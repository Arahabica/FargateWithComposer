#!/bin/bash

# Just Parse parameters
if [ "$#" -lt  "3" ]; then
  echo "USAGE:"
  echo "$ push.sh REPOSITORY DIR AWS_ACCOUNT_ID AWS_REGION"
  exit 1
fi

REPOSITORY=${1}
DIR=${2}
AWS_ACCOUNT_ID=${3}
AWS_REGION=${4}

if [ ! -n "${AWS_REGION}" ]; then
   AWS_REGION=ap-northeast-1
fi

# Main
aws ecr create-repository --repository-name ${REPOSITORY}
docker build -t ${REPOSITORY} ${DIR}
docker tag ${REPOSITORY}:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPOSITORY}:latest
docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPOSITORY}:latest
