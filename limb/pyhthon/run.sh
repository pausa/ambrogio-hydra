#!/usr/bin/env bash
# Example script to run the docker container
AMBROGIO_HOME=~/.config/ambrogio
mkdir -p $AMBROGIO_HOME
# Making it secure, as secrets are stored in there
chmod 700 $AMBROGIO_HOME

docker run --rm \
  -u "$(id -u)" \
  -v $AMBROGIO_HOME:/workspace/config \
  ambrogio-limb-python:0.0.1 "$@"