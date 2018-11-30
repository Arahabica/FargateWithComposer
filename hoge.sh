DIR=nginx
REPOSITORY=test-express-2-express
AWS_ACCOUNT_ID=636061485504
AWS_REGION=ap-northeast-1

aws ecr create-repository --repository-name ${REPOSITORY}
`aws ecr get-login --no-include-email`
docker build -t ${REPOSITORY} ${DIR}
docker tag ${REPOSITORY}:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPOSITORY}:latest
docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPOSITORY}:latest
