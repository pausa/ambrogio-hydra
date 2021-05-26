#!/usr/bin/env bash
# Example script to run the docker container
# The goal is to minimize latency when invoking the command
AMBROGIO_HOME=~/.config/ambrogio
mkdir -p $AMBROGIO_HOME
# Making it secure, as secrets are stored in there
chmod 700 $AMBROGIO_HOME

docker run -it --rm \
  -u "$(id -u)" \
  -v $AMBROGIO_HOME:/workspace/config \
  --name ambrogio-limb-python \
  --entrypoint /bin/bash -d \
  ambrogio-limb-python:0.0.1 2> /dev/null

docker exec ambrogio-limb-python python main.py "$@"