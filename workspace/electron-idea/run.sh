#!/usr/bin/env fish
set UID (id -u)
# Needs to be privileged, in order for electron to work
docker run --rm -u $UID \
    -e DISPLAY=$DISPLAY \
    -v /usr/share/themes:/usr/share/themes \
    -v /usr/share/icons:/usr/share/icons \
    -v /usr/share/fonts:/usr/share/fonts \
    -v $HOME/git/ambrogio-hydra/home:/workspace/home \
    -v $HOME/git:/workspace/git \
    --privileged \
    --net=host \
    --name=electron-idea \
    electron-idea
