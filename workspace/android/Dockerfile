FROM ubuntu:rolling
ARG UID
ENV DEBIAN_FRONTEND noninteractive

# This makes sure that a user with the same UID as provided exists in the
# machine. It saves some effort in forwarding X11
RUN id -nu $UID || useradd -ms /bin/bash dev -u $UID
RUN mkdir /workspace \
 && chown $UID /workspace \
 && usermod -d /workspace/home -m $(id -nu $UID)

# x11 libraries
RUN apt-get update -y \
 && apt-get -y install \
    fish \
    vim \
    wget \
    unzip \
    pv \
    x11-apps \
    libgl1-mesa-glx \
    mesa-utils \
    libgl1-mesa-dri \
    git \
    fontconfig \
 && apt-get clean

# Android studio dependencies
RUN dpkg --add-architecture i386 \
 && apt-get update -y \
 && apt-get -y install \
    libc6:i386 \
    libncurses5:i386 \
    libstdc++6:i386 \
    libbz2-1.0:i386 \
    lib32z1 \
 && apt-get clean

USER $UID
RUN mkdir /workspace/android
WORKDIR /workspace/android
RUN wget --progress=dot:giga 'https://redirector.gvt1.com/edgedl/android/studio/ide-zips/4.1.3.0/android-studio-ide-201.7199119-linux.tar.gz' -O studio.tar.gz \
 && echo 'extracting' \
 && pv -f studio.tar.gz | tar -xz --strip 1 \
 && echo 'cleaning' \
 && rm -v studio.tar.gz

# more android studio deps
USER 0
RUN apt-get update -y \
 && apt-get -y install \
    libxtst6 \
    libxi6 \
    libnss3 \
    libnspr4 \
    libxss1 \
    libgbm1 \
    libglib2.0-0 \
    libxrandr2 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libxcomposite1 \
    libdbus-1-3 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libcups2 \
    libatspi2.0-0 \
    libdbus-glib-1-2 \
    libdbusmenu-glib4 \
    libgtk-3-0 \
    libxrandr2 \
    x11-xserver-utils \
    qemu \
    qemu-kvm \
 && apt-get clean
RUN addgroup kvm
RUN usermod -aG kvm $(awk -v uid=$UID -F":" '{ if($3==uid){print $1} }' /etc/passwd)
USER $UID

# Installing plugins
RUN mkdir -p /workspace/setup
WORKDIR /workspace/setup
COPY install-plugins.sh .
RUN ./install-plugins.sh \
 && cd /workspace \
 && rm -rf /workspace/setup

RUN mkdir -p /workspace/init/home
WORKDIR /workspace/init/home
COPY ideavimrc .ideavimrc

COPY entry.sh /workspace/bin/entry.sh

WORKDIR /workspace/home
ENTRYPOINT ["/workspace/bin/entry.sh"]
