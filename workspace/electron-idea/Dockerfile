FROM node-electron:latest
ARG UID
ARG IDEA_VERSION="ideaIU-2021.1.1"

RUN mkdir -p /workspace/idea && chown $UID /workspace/idea
COPY entry.sh /workspace/bin/entry.sh
WORKDIR /workspace/idea

USER $UID
RUN wget "https://download.jetbrains.com/idea/$IDEA_VERSION.tar.gz" -O idea.tar.gz
RUN tar xvf idea.tar.gz --strip 1 && rm idea.tar.gz

RUN mkdir -p /workspace/setup
WORKDIR /workspace/setup
COPY install-plugins.sh .
RUN ./install-plugins.sh \
 && cd /workspace \
 && rm -rf /workspace/setup

RUN mkdir -p /workspace/init/home
WORKDIR /workspace/init/home
COPY ideavimrc .ideavimrc

# Android emulator dependencies
USER 0
RUN dpkg --add-architecture i386 \
 && apt-get update \
 && apt-get install -y \
    libc6:i386 \
    libncurses5:i386 \
    libstdc++6:i386 \
    lib32z1 \
    libbz2-1.0:i386 \
    libpulse0 \
 && apt-get clean
USER $UID

# Python dependencies
USER 0
RUN dpkg --add-architecture i386 \
 && apt-get update \
 && apt-get install -y \
    python3-pip \
    pipenv \
 && apt-get clean
USER $UID

COPY entry.sh /workspace/bin/entry.sh
WORKDIR /workspace/home
ENTRYPOINT /workspace/bin/entry.sh
