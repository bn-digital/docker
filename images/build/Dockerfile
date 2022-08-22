# syntax docker/dockerfile:latest
ARG nodejs_version="18"
ARG os_version="bullseye-slim"
FROM node:${nodejs_version}-${os_version} AS yarn
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
      # clean up
      && rm -rf /var/lib/apt/lists/* \
      && apt-get clean
ENV YARN_CACHE_FOLDER=/var/cache/yarn
WORKDIR /usr/local/src
COPY app .
RUN yarn config set enableGlobalCache true \
 && yarn config set nodeLinker node-modules \
 && yarn config set nmHoistingLimits workspaces \
 && yarn config set enableTelemetry false \
 && yarn config set preferAggregateCacheInfo true \
 && yarn \
 && yarn rebuild \
 && rm -rf /usr/local/src
WORKDIR /usr/local/src
VOLUME ["/var/cache/yarn"]
VOLUME ["/root/.cache"]
