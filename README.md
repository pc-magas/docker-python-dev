# A simple python container for cli-development
A simple python contaner spawning the python 3 version for python app development.
It boostraps the virtualenv and automatically installs all the required pip dependencies.

## Volumes, enviromental variables and build arguments

The folder `/home/developer/code` is being exported as volume. Also you can set the setting `PROJECT_PATH` to `.env` in order to specify the path that will be mounted as volume.

Also the following enviromental variables are used:

Name | Default Value | Purpoce
--- | --- | ---
`DOCKER_UID`  | 1000 | Use that to change the user id on the fly. Usefull for multi-user environments
`DOCKER_GID` | 1000 | Use that to change the user group id on the fly. Usefull for multi-user environments
`DEPENDENCIES_FILE` | N/A | File that is generated via `pip freeze` and contains your project's dependencies. **NOTE:** The path is assumed relatively to the source code root.
`DEV_HOME` | "/home/developer" | Home of the in-container developer account.
`DEV_SRC_PATH` | "${DEV_HOME}/code" | Location that will be mounted as volume and contains the project's source code
`VENV_FOLDER` | env | The name of the virtual environment.

## Recommended Usage
### Docker-compose based one
I would reccomend creating the following docker-compose.yml to your project's root

```
version: '3'

services:

  python_dev:
    image: pc-magas/python_dev:3
    stdin_open: true
    tty: true
    volumes:
      - $PROJECT_PATH:/home/developer/code
    environment:
      - DEPENDENCIES_FILE=$DEPENDENCIES_FILE
```

Then create this `.env` file:

```
PROJECT_PATH=^path_file^
DEPENDENCIES_FILE=^dependencies_file^
```
Where `^path_file^` is the project's root and `^dependencies_file^` is the `pip freeze` generated file.

In case that the user is or the default users group is **NOT** `1000` use the following `docker-compose.yml`:

```
version: '3'

services:

  python_dev:
    image: pc-magas/python_dev:3
    stdin_open: true
    tty: true
    volumes:
      - $PROJECT_PATH:/home/developer/code
    environment:
      - DEPENDENCIES_FILE=$DEPENDENCIES_FILE
      - DOCKER_UID=$UID
      - DOCKER_GID=$GID
```
And generate the `.env` like that:

```
cd ^path_file^
echo "PROJECT_PATH"=$(pwd) >> .env
echo "UID="$(id -u) >>.env
echo "UID="$(id -g) >>.env
echo "DEPENDENCIES_FILE=^depndencies_file^" >>.env
```
Where on the commands above the `^path_file^` is the project's root and `^dependencies_file^` is the `pip freeze` generated file.

Then via the following command you can launch it:

```
docker-compose run python_dev
```

## Further notices:

Do not be alarmed by the follwing errors during container launch:

> bash: cannot set terminal process group (-1): Inappropriate ioctl for device
> bash: no job control in this shell
> bash: cd: too many arguments
