FROM python:3

ENV DOCKER_UID=1000
ENV DOCKER_GID=1000
ENV VENV_FOLDER=env
ENV DEPENDENCIES_FILE=""

ENV DEV_HOME="/home/developer"
ENV DEV_SRC_PATH="${DEV_HOME}/code"

RUN mkdir -p ${DEV_SRC_PATH} &&\
    groupadd -g ${DOCKER_GID} developer &&\
    useradd -d ${DEV_HOME} -u ${DOCKER_UID} -g ${DOCKER_GID} -s /bin/bash developer &&\
    chown -R developer:developer ${DEV_HOME} &&\
    pip install virtualenv

COPY .bashrc_new ${DEV_HOME}/.bashrc
RUN chown developer:developer ${DEV_HOME}/.bashrc &&\
    chmod +x ${DEV_HOME}/.bashrc

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

VOLUME $DEV_SRC_PATH
WORKDIR $DEV_SRC_PATH

ENTRYPOINT /usr/bin/entrypoint.sh
