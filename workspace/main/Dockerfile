FROM ambrogio-hydra/workspace/ide:latest
ARG DEBIAN_FRONTEND="noninteractive"
RUN wget https://deb.nodesource.com/setup_lts.x -O /tmp/node_setup.sh \
 && bash /tmp/node_setup.sh \
 && rm /tmp/node_setup.sh
RUN apt-get install -y nodejs build-essential

## Chromium dependencies (needed for electron)
RUN apt-get install -y ca-certificates \
                       fonts-liberation \
                       libappindicator3-1 \
                       libasound2 \
                       libatk-bridge2.0-0 \
                       libatk1.0-0 \
                       libc6 \
                       libcairo2 \
                       libcups2 \
                       libdbus-1-3 \
                       libexpat1 \
                       libfontconfig1 \
                       libgbm1 \
                       libgcc1 \
                       libglib2.0-0 \
                       libgtk-3-0 \
                       libnspr4 \
                       libnss3 \
                       libpango-1.0-0 \
                       libpangocairo-1.0-0 \
                       libstdc++6 \
                       libx11-6 \
                       libx11-xcb1 \
                       libxcb1 \
                       libxcomposite1 \
                       libxcursor1 \
                       libxdamage1 \
                       libxext6 \
                       libxfixes3 \
                       libxi6 \
                       libxrandr2 \
                       libxrender1 \
                       libxss1 \
                       libxtst6 \
                       lsb-release \
                       wget \
                       xdg-utils

# Making and giving permissions to needed dirs that might also be mounted on the host system
RUN mkdir /home/user/.cache \
 && chmod 777 /home/user/.cache

RUN mkdir /home/user/.config \
 && chmod 777 /home/user/.config
