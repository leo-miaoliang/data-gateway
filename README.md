# data-gateway

端口 30010

# 编译 & 发布

镜像打包：
`ENV_NAME=${ENV_NAME} DOCKER_REPO=${DOCKER_REPO} ./docker/build.sh`

本地运行：
`ENV_NAME=${ENV_NAME} DOCKER_REPO=${DOCKER_REPO} ./docker/run.sh`

其它环境初始发布：
`ENV_NAME=${ENV_NAME} DOCKER_REPO=${DOCKER_REPO} ./docker/swarm/init-deployment.sh`

其它环境增量发布：
`ENV_NAME=${ENV_NAME} DOCKER_REPO=${DOCKER_REPO} ./docker/swarm/update-deployment.sh`

# 验证

环境验证：
`curl http://svc.uuabc.com/api/datagateway/ -d '{"sql_txt": "select 1"}' -X POST`

正常结果：
`{"data":[[1]],"is_success":true}`