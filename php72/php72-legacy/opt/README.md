# Shell scripts
The shell scripts in this directory provide multiple hooks in the lifecycle of your container.

## directories.sh
Called first and should be used to create the directory structure your application needs. (e.g. work and log directories)

## permissions.sh
Is called multiple times and is used to set the access rights to your applications directories (the ones you created in directories.sh)

## bootstrap-project.sh
This file may be used to execute additional scripts, like warming up caches when the docker container starts