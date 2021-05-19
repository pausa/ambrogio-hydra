#!/usr/bin/env fish
set UID (id -u)
docker build --no-cache . -t node-electron:latest || exit 1
# Needs to be privileged, in order for electron to work
docker run -it --rm -u $UID \
    -e DISPLAY=$DISPLAY \
    -v $HOME/git:/workspace/git \
    --privileged \
    --net=host node-electron
