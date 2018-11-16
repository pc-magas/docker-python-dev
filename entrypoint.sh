#!/bin/bash

USER_ID=$(id -u developer)
GROUP_ID=$(id -g developer)

if [ ${DOCKER_UID} != ${USER_ID} ]; then
  usermod -u ${DOCKER_UID} developer
fi

if [ ${DOCKER_GID} != ${GROUP_ID} ]; then
  groupmod -g ${DOCKER_GID} developer
fi

script="if [ -f /home/developer/code/${VENV_FOLDER}/bin/activate ]; then source /home/developer/code/${VENV_FOLDER}/bin/activate; fi; cd /home/developer/code/
pip install -r /home/developer/code/${DEPENDENCIES_FILE}"

if [ ! -f /home/developer/.bashrc ]; then
  echo $script >> /home/developer/.bashrc
fi


su developer -c "bash"
