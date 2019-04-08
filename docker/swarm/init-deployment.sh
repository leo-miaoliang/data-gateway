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

# debug
# docker-compose -f data-gateway.yaml up -d api
docker stack deploy -c data-gateway.yaml data-gateway --with-registry-auth