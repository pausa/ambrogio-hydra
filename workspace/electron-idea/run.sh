#!/usr/bin/env fish
set UID (id -u)

if [ -z "$XAUTHORITY" ]
    echo "XAUTHORITY not set" > /dev/stderr
    set xauth_params -v $HOME/.Xauthority:/workspace/home/.Xauthority -e XAUTHORITY=/workspace/home/.Xauthority
else
    echo "XAUTHORITY set" > /dev/stderr
    set xauth_params -e XAUTHORITY=$XAUTHORITY
end 
# Needs to be privileged, in order for electron to work
docker rm electron-idea
docker run  -u $UID \
    -e DISPLAY=$DISPLAY \
    -v /usr/share/themes:/usr/share/themes \
    -v /usr/share/icons:/usr/share/icons \
    -v /usr/share/fonts:/usr/share/fonts \
    -v $HOME/git/ambrogio-hydra/home:/workspace/home \
    -v $HOME/git:/workspace/git \
    $xauth_params \
    --privileged \
    --net=host \
    --name=electron-idea \
    electron-idea
