#!/bin/bash

if [ "${ENV_NAME}" = '' ]; then
  echo 'ENV_NAME is unset'
  exit 1;
fi

if [ "${DOCKER_REPO}" = '' ]; then
  echo 'DOCKER_REPO is unset'
  exit 1;
fi

IMAGE_URL=${DOCKER_REPO}/data-gateway:${ENV_NAME}
INSTANCE_NAME=data-gateway
EXPOSED_PORT=30010
PUBLISHED_PORT=$EXPOSED_PORT

if [ $? -eq 0 ] && [ "$ENV_NAME" != "local" ]
then
	docker login -u ${DOCKER_REPO_USER} -p ${DOCKER_REPO_PASSWORD} ${DOCKER_REPO}
	docker pull $IMAGE_URL
fi

if [ $? -eq 0 ]
then
	docker stop $INSTANCE_NAME
	docker rm --force \
		$INSTANCE_NAME

	docker run -d	\
		--name $INSTANCE_NAME	\
		-p $PUBLISHED_PORT:$EXPOSED_PORT 	\
		--restart=always		\
		$IMAGE_URL	\
		-
fi
