#!/usr/bin/env fish
set UID (id -u)
docker build . -t electron-idea:latest --build-arg UID=$UID || exit 1
