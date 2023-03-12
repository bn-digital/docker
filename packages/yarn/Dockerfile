# syntax docker/dockerfile:latest
ARG nodejs_version="18"
ARG os_version="bullseye-slim"
FROM node:${nodejs_version}-${os_version}
RUN apt-get update --fix-missing \
 && apt-get upgrade --yes \
 && apt-get dist-upgrade --yes \
 && apt-get install --no-install-recommends --no-install-suggests --yes \
      bash \
      build-essential \
      ca-certificates \
      curl \
      g++ \
      gcc \
      gnupg \
      gyp \
      libasound2 \
      libexpat1-dev \
      libgbm-dev \
      libgconf-2-4 \
      libglib2.0-dev \
      libgsf-1-dev \
      libgtk-3-0 \
      libgtk2.0-0 \
      libjpeg-dev \
      libnotify-dev \
      libnss3 \
      libsqlite3-dev \
      libssl-dev \
      libtiff5-dev \
      libvips-dev \
      libxss1 \
      libxtst6 \
      lsb-release \
      make \
      nano \
      sqlite3 \
      ttf-wqy-microhei \
      ttf-wqy-zenhei \
      vim-tiny \
      wget \
      xauth \
      xfonts-wqy \
      xvfb \
      && rm -rf /var/lib/apt/lists/* \
      && apt-get clean
WORKDIR /usr/local/src
COPY app .
ENV YARN_CACHE_FOLDER=/var/cache/yarn
RUN yarn \
 && yarn rebuild \
 && rm -rf /usr/local/src
ONBUILD WORKDIR /usr/local/src
ONBUILD ENV YARN_CACHE_FOLDER=/var/cache/yarn
