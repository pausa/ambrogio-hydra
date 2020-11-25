#!/usr/bin/env bash
# this can be a template, I imagine if somebody else is using it, they have a different configuration
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
xauth nlist :0 | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
docker run -ti --rm -v $XSOCK:$XSOCK \
    -v $XAUTH:$XAUTH \
    -v /usr/share/icons/Pop:/usr/share/icons/Pop:ro \
    -v /usr/share/fonts:/usr/share/fonts:ro \
    -v $HOME/.config/JetBrains:/home/user/.config/JetBrains \
    -v $HOME/.cache/JetBrains:/home/user/.cache/JetBrains \
    -v $HOME/.local/share/JetBrains:/home/user/.local/share/JetBrains \
    -v $HOME/.icons:/home/user/.icons \
    -v $HOME/.java:/home/user/.java \
    -v $HOME/git:/home/user/projects \
    -e XAUTHORITY=$XAUTH \
    -e DISPLAY=$DISPLAY \
    -e TZ=$(cat /etc/timezone) \
    -u 0 \
    ambrogio-hydra/workspace/d-env:latest /usr/bin/fish
