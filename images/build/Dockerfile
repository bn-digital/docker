# syntax docker/dockerfile:latest
FROM node:16-bullseye-slim AS yarn
ENV YARN_GLOBAL_FOLDER=/usr/local/yarn
WORKDIR /usr/local/src
COPY app .
RUN yarn

FROM summerwind/actions-runner-dind:latest
LABEL org.opencontainers.image.authors="BN Enginseers" \
      org.opencontainers.image.url="https://github.com/bn-digital/docker" \
      org.opencontainers.image.vendor="BN Digital" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.title="NodeJS DinD Build Pack for Github Workflows" \
      org.opencontainers.image.description="Base environment used for building NodeJS applications in Docker with Github Action runner"
USER root
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
      libssl-dev \
      wget \
 && curl -fsSL https://deb.nodesource.com/setup_current.x | bash - \
 && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /usr/share/keyrings/yarnkey.gpg > /dev/null \
 && echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list \
 && apt-get update \
 && apt-get install --yes nodejs yarn \
 && apt-get clean \
 && apt-get autoremove \
 && rm -rf /var/lib/apt/lists/* /etc/apt/sources.list.d/* /requirements.apt \
 && yarn global add \
      @bn-digital/vault-env \
      concurrently \
      eslint \
      less \
      npm \
      prettier \
      sass \
      stylelint \
      typescript \
      yarn
ENV YARN_GLOBAL_FOLDER=/usr/local/yarn
VOLUME ["/usr/local/yarn"]
COPY --from=yarn --chown=bn /usr/local/yarn /usr/local/yarn
WORKDIR /runner
ONBUILD WORKDIR /usr/local/src
