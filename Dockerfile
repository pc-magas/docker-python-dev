# This file is part of pcmagas/pythom_dev.

#    Foobar is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    Foobar is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with Foobar.  If not, see <https://www.gnu.org/licenses/>.
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
