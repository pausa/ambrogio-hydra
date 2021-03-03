#!/usr/bin/env fish
set UID (id -u)
docker build . -t node-x11:latest --build-arg UID=$UID
docker run -it --rm -e DISPLAY=$DISPLAY -u $UID --net=host node-x11
