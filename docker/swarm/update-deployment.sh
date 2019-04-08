#!/usr/bin/env bash

if [ "${ENV_NAME}" = '' ]; then
  echo 'ENV_NAME is unset'
  exit 1;
fi

if [ "${DOCKER_REPO}" = '' ]; then
  echo 'DOCKER_REPO is unset'
  exit 1;
fi

echo "ENV_NAME:${ENV_NAME},DOCKER_REPO:${DOCKER_REPO}"

docker service update --force --image=${DOCKER_REPO}/data-gateway:${ENV_NAME}  data-gateway_api
