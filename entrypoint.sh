#!/bin/bash

USER_ID=$(id -u developer)
GROUP_ID=$(id -g developer)

if [ ${DOCKER_UID} != ${USER_ID} ]; then
  usermod -u ${DOCKER_UID} developer
fi

if [ ${DOCKER_GID} != ${GROUP_ID} ]; then
  groupmod -g ${DOCKER_GID} developer
fi

chown -R developer:developer ${DEV_HOME}/.cache/pip/http


su developer -c "bash"
