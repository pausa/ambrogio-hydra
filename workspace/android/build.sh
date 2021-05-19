#!/usr/bin/env fish
set UID (id -u)
docker build . -t android:latest --build-arg UID=$UID || exit 1
docker run -it --rm -e DISPLAY=$DISPLAY -u $UID --net=host --entrypoint=fish --privileged android
