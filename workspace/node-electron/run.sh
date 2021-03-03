#!/usr/bin/env fish
set UID (id -u)
docker build . -t node-electron:latest
# Needs to be privileged, in order for electron to work
docker run -it --rm -u $UID \
    -e DISPLAY=$DISPLAY \
    -v $HOME/git:/workspace/git \
    --privileged \
    --net=host node-electron
