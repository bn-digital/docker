# syntax docker/dockerfile:latest
ARG nodejs_version=18
ARG os_version=alpine
FROM node:${nodejs_version}-${os_version} AS yarn
ENV YARN_GLOBAL_FOLDER=/var/cache/yarn
WORKDIR /usr/local/src
COPY app .
VOLUME ["/usr/local/src"]
VOLUME ["/var/cache/yarn"]
RUN apk add --update --no-cache alpine-sdk \
 && apk upgrade --available \
 && yarn config set enableGlobalCache true \
 && yarn config set globalFolder $YARN_GLOBAL_FOLDER \
 && yarn config set nodeLinker node-modules \
 && yarn config set nmHoistingLimits workspaces \
 && yarn config set enableTelemetry false \
 && yarn config set preferAggregateCacheInfo true \
 && yarn plugin import workspace-tools \
 && yarn plugin import interactive-tools \
 && yarn plugin import version \
 && yarn plugin import typescript \
 && yarn \
 && yarn rebuild \
 && rm -rf /usr/local/src/*

FROM node:${nodejs_version} AS default
LABEL org.opencontainers.image.authors="BN Enginseers <dev@bndigital.co>" \
      org.opencontainers.image.url="https://github.com/bn-digital/docker" \
      org.opencontainers.image.source="https://github.com/bn-digital/docker" \
      org.opencontainers.image.vendor="BN Digital" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.title="NodeJS DinD Build Pack for Github Workflows" \
      org.opencontainers.image.description="Base environment used for building NodeJS applications in Docker with Github Action runner"
USER root
WORKDIR /usr/local/src
ENV YARN_GLOBAL_FOLDER=/usr/local/yarn
RUN apt-get update --fix-missing \
 && apt-get upgrade --yes \
 && apt-get dist-upgrade --yes \
 && apt-get install --no-install-recommends --no-install-suggests --yes \
      apt-transport-https \
      bash \
      build-essential \
      ca-certificates \
      curl \
      g++ \
      gcc \
      gnupg \
      gyp \
      libexpat1-dev \
      libglib2.0-dev \
      libgsf-1-dev \
      libjpeg-dev \
      libsqlite3-dev \
      libssl-dev \
      libtiff5-dev \
      libvips-dev \
      lsb-release \
      make \
      sqlite3 \
      wget \
 && curl -fsSL https://deb.nodesource.com/setup_17.x | bash - \
 && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /usr/share/keyrings/yarnkey.gpg > /dev/null \
 && echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list \
 && apt-get update \
 && apt-get install --yes nodejs yarn \
 && apt-get clean \
 && apt-get autoremove \
 && rm -rf /var/lib/apt/lists/* /etc/apt/sources.list.d/* /requirements.apt \
 && yarn global add \
      @bn-digital/vault-env \
      eslint \
      less \
      node-gyp \
      @mapbox/node-pre-gyp \
      npm \
      prettier \
      sass \
      sqlite3 \
      @vscode/sqlite3 \
      stylelint \
      tar \
      typescript
VOLUME ["/usr/local/yarn"]
COPY --from=yarn --chown=runner /usr/local/yarn /usr/local/yarn
COPY --from=yarn --chown=runner /usr/local/src/.yarn /usr/local/src/.yarn
COPY --from=yarn --chown=runner /usr/local/src/.yarnrc.yml /usr/local/src/.yarnrc.yml
USER node
WORKDIR /usr/local/src
