# syntax docker/dockerfile:latest
ARG pulumi_version="3.67.1"
FROM pulumi/pulumi:${pulumi_version} AS pulumi
FROM summerwind/actions-runner-dind:ubuntu-22.04 AS base
USER runner


ARG nodejs_version="18.16.0"
FROM base AS build
LABEL org.opencontainers.image.authors="BN Enginseers <dev@bndigital.co>" \
      org.opencontainers.image.url="https://github.com/bn-digital/docker" \
      org.opencontainers.image.source="https://github.com/bn-digital/docker" \
      org.opencontainers.image.vendor="BN Digital" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.title="NodeJS DinD Build Pack for Github Workflows" \
      org.opencontainers.image.description="Base environment used for building NodeJS applications in Docker with Github Action runner"
USER root
COPY --from=pulumi /usr/local/aws-cli/v2/current /home/runner/.local/aws
COPY --from=pulumi /usr/bin/pulumi /home/runner/.local/bin/pulumi
COPY --from=pulumi /usr/bin/kubectl /home/runner/.local/bin/kubectl
RUN apt-get update --fix-missing \
 && apt-get upgrade --yes \
 && apt-get full-upgrade --yes \
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
      lsb-release \
      make \
      wget \
 && curl -fsSL https://deb.nodesource.com/setup_${nodejs_version}.x | bash - \
 && apt-get update \
 && apt-get install --yes nodejs npm \
 && npm install --global yarn \
 && apt-get clean \
 && apt-get autoremove \
 && rm -rf /var/lib/apt/lists/* /etc/apt/sources.list.d/* /requirements.apt \
 && ln -s /home/runner/.local/aws/bin/aws /home/runner/.local/bin/aws

FROM base
COPY --from=build / /
COPY --from=build --chown=runner /home/runner /home/runner
