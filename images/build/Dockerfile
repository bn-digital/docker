# syntax docker/dockerfile:latest
ARG nodejs_version=18
ARG os_version=alpine3.15
FROM node:${nodejs_version}-${os_version} AS yarn
ENV YARN_GLOBAL_FOLDER=/var/cache/yarn
WORKDIR /usr/local/src
COPY app .
VOLUME ["/var/cache/yarn"]
RUN apk add --update --no-cache \
      alpine-sdk \
      sqlite-libs \
      python3 \
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
VOLUME ["/usr/local/src"]
