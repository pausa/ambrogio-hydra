FROM node:15-buster
ARG UID

# This makes sure that a user with the same UID as provided exists in the
# machine. It saves some effort in forwarding X11
RUN id -nu $UID || useradd -ms /bin/bash dev -u $UID
RUN mkdir /workspace \
 && chown $UID /workspace \
 && usermod -d /workspace/home -m $(id -nu $UID)

RUN apt-get update -y \
    && apt-get -y install \
		fish \ 
		vim \ 
		x11-apps \
		libgl1-mesa-glx \
		mesa-utils \
		libgl1-mesa-dri \
    && apt-get clean

WORKDIR /workspace
ENTRYPOINT ["fish"]
