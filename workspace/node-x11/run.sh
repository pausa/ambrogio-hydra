#!/usr/bin/env fish
set UID (id -u)
docker build --no-cache . -t node-x11:latest --build-arg UID=$UID
docker run -it --rm -e DISPLAY=$DISPLAY -u $UID -v /dev:/dev --net=host node-x11
