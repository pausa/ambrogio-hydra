#!/usr/bin/env bash

docker build \
    --build-arg USER=$USER \
    --build-arg UID=$(id -u) \
    . -t ambrogio-hydra/workspace/ide:latest
