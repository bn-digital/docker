# syntax docker/dockerfile:latest
ARG nodejs_version=18
ARG os_version="bullseye-slim"
FROM node:${nodejs_version}-${os_version} AS base
WORKDIR /usr/local/src

FROM base AS build
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
COPY app .
RUN npm i -g npm \
 && yarn \
 && yarn rebuild \
 && rm -rf /usr/local/src

FROM base
COPY --from=build / /
