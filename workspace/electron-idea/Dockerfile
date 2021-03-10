FROM node-electron:latest
ARG UID
ARG IDEA_VERSION="ideaIU-2020.3.2"

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

USER 0
RUN apt-get update \
 && apt-get install -y libgl1-mesa-glx mesa-utils libgl1-mesa-dri \
 && apt-get clean
USER $UID

WORKDIR /workspace/home
ENTRYPOINT /workspace/bin/entry.sh
