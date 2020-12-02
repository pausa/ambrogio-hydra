FROM ubuntu:latest
ARG USER
ARG UID
ARG DEBIAN_FRONTEND="noninteractive"
RUN apt-get update
# base packages and base setup (maybe extract when need more ides)
RUN apt-get install -qqy x11-apps xterm fish vim wget git fontconfig
RUN adduser --disabled-password --system --group --home /home/user --uid $UID --shell /usr/bin/fish $USER
RUN mkdir -p /opt/idea
WORKDIR /opt/idea
RUN wget 'https://download.jetbrains.com/idea/ideaIU-2020.3.tar.gz' -O idea.tar.gz
RUN tar xvf idea.tar.gz --strip 1 && rm idea.tar.gz

COPY entry.sh /opt/bin/entry.sh

WORKDIR /home/user
CMD /opt/bin/entry.sh
