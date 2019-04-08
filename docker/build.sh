#!/bin/bash

if [ "${ENV_NAME}" = '' ]; then
  echo 'ENV_NAME is unset'
  exit 1;
fi

if [ "${DOCKER_REPO}" = '' ]; then
  echo 'DOCKER_REPO is unset'
  exit 1;
fi

DOCKER_DIR=$(dirname $0)
CONTEXT_DIR=$DOCKER_DIR/..
IMAGE_URL=${DOCKER_REPO}/data-gateway:${ENV_NAME}

if [[ "$OSTYPE" == "darwin"* ]]; then

	# https://docs.docker.com/docker-for-mac/networking/#use-cases-and-workarounds

		# --build-arg http_proxy=http://host.docker.internal:1087 	\
		# --build-arg https_proxy=http://host.docker.internal:1087 	\

	docker build \
		--build-arg BUILD_ENV=${ENV_NAME}  \
		--force-rm 					\
		-f $CONTEXT_DIR/Dockerfile	\
		-t $IMAGE_URL 				\
		$CONTEXT_DIR

else

	docker build \
		--build-arg BUILD_ENV=${ENV_NAME}  \
		--force-rm 					\
		-f $CONTEXT_DIR/Dockerfile	\
		-t $IMAGE_URL 				\
		$CONTEXT_DIR

fi


if [ $? -eq 0 ] && [ "$ENV_NAME" != "local" ]
then
	if [ "$(docker login ${DOCKER_REPO} < /dev/null | grep 'Login Succeeded')" = '' ]; then
		echo "Log into docker registry:"

		if [ "${DOCKER_REPO_USER}" = '' ]; then
			echo 'DOCKER_REPO_USER is unset'
			exit 1;
		fi

		if [ "${DOCKER_REPO_PASSWORD}" = '' ]; then
			echo 'DOCKER_REPO_PASSWORD is unset'
			exit 1;
		fi

		docker login -u ${DOCKER_REPO_USER} -p ${DOCKER_REPO_PASSWORD} ${DOCKER_REPO}
	fi
	docker push $IMAGE_URL
fi

