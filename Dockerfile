FROM python:3

ENV DOCKER_UID=1000
ENV DOCKER_GID=1000
ENV VENV_FOLDER=env
ENV DEPENDENCIES_FILE=""
ENV DEV_HOME="/home/developer"
ENV DEV_SRC_PATH="${DEV_HOME}/code"

RUN mkdir -p ${DEV_SRC_PATH} &&\
    pip install virtualenv &&\
    groupadd -g ${DOCKER_GID} developer &&\
    useradd -d ${DEV_HOME} -u ${DOCKER_UID} -g ${DOCKER_GID} -s /bin/bash developer

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

VOLUME /home/developer/code
WORKDIR /home/developer/code

ENTRYPOINT /usr/bin/entrypoint.sh
