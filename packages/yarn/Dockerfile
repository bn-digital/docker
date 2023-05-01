# syntax docker/dockerfile:latest
ARG nodejs_version="20"
ARG os_version="bullseye-slim"
FROM node:${nodejs_version}-${os_version}
RUN apt-get update --fix-missing \
 && apt-get upgrade --yes \
 && apt-get dist-upgrade --yes \
 && apt-get install --no-install-recommends --no-install-suggests --yes \
      bash \
      ca-certificates \
      gnupg \
      curl \
      wget \
      build-essential \
      g++ \
      gcc \
      gyp \
      libssl-dev \
      libnotify-dev \
      libexpat1-dev \
      libgbm-dev \
      libjpeg-dev \
      libsqlite3-dev \
      libtiff5-dev \
      libvips-dev \
      libxss1 \
      libxtst6 \
      make \
      nano \
      sqlite3 \
      xauth \
      xfonts-wqy \
      xvfb \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get clean
WORKDIR /usr/local/src
COPY app .
ENV YARN_CACHE_FOLDER=/var/cache/yarn
RUN npm i -g npm \
 && yarn \
 && yarn rebuild \
 && rm -rf /usr/local/src
ONBUILD WORKDIR /usr/local/src
ONBUILD ENV YARN_CACHE_FOLDER=/var/cache/yarn
