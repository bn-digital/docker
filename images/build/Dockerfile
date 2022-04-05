# syntax docker/dockerfile:latest
ARG nodejs_version=16.14.2
FROM node:${nodejs_version}-slim AS yarn
ENV YARN_GLOBAL_FOLDER=/usr/local/yarn
WORKDIR /usr/local/src
COPY app .
VOLUME ["/usr/local/src"]
VOLUME ["/usr/local/yarn"]
RUN apt-get update --fix-missing \
 && apt-get upgrade --yes \
 && apt-get dist-upgrade --yes \
 && apt-get install --no-install-recommends --no-install-suggests --yes \
      git \
      ca-certificates \
      build-essential \
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
 && yarn rebuild

FROM summerwind/actions-runner-dind:v2.289.2-ubuntu-20.04 AS default
LABEL org.opencontainers.image.authors="BN Enginseers <dev@bndigital.co>" \
      org.opencontainers.image.url="https://github.com/bn-digital/docker" \
      org.opencontainers.image.source="https://github.com/bn-digital/docker" \
      org.opencontainers.image.vendor="BN Digital" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.title="NodeJS DinD Build Pack for Github Workflows" \
      org.opencontainers.image.description="Base environment used for building NodeJS applications in Docker with Github Action runner"
USER root
WORKDIR /usr/local/src
RUN apt-get update --fix-missing \
 && apt-get upgrade --yes \
 && apt-get dist-upgrade --yes \
 && apt-get install --no-install-recommends --no-install-suggests --yes \
      apt-transport-https \
      bash \
      build-essential \
      ca-certificates \
      lsb-release \
      curl \
      gnupg \
      g++ \
      gcc \
      gyp \
      make \
      libexpat1-dev \
      libglib2.0-dev \
      libgsf-1-dev \
      libjpeg-turbo8-dev \
      libsqlite3-dev \
      libssl-dev \
      libtiff5-dev \
      libvips-dev \
      sqlite3 \
      wget \
 && curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
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
ENV YARN_GLOBAL_FOLDER=/usr/local/yarn
VOLUME ["/usr/local/yarn"]
COPY --from=yarn --chown=runner /usr/local/yarn /usr/local/yarn
COPY --from=yarn --chown=runner /usr/local/src/.yarn /usr/local/src/.yarn
COPY --from=yarn --chown=runner /usr/local/src/.yarnrc.yml /usr/local/src/.yarnrc.yml
USER runner
WORKDIR /runner
ONBUILD USER root
ONBUILD WORKDIR /usr/local/src
ONBUILD COPY ./package.json .
