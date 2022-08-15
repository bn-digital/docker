# syntax docker/dockerfile:latest
ARG nodejs_version="18.7.0"
ARG os_version="alpine3.16"
FROM node:${nodejs_version}-${os_version} AS yarn
WORKDIR /usr/local/src
ENV YARN_CACHE_FOLDER=/var/cache/yarn
COPY app .
RUN apk add --update --no-cache \
      alpine-sdk \
      build-base \
      sqlite-libs \
      python3 \
      openssl \
 && apk upgrade --available \
 && yarn config set enableGlobalCache true \
 && yarn config set nodeLinker node-modules \
 && yarn config set nmHoistingLimits workspaces \
 && yarn config set enableTelemetry false \
 && yarn config set preferAggregateCacheInfo true \
 && yarn \
 && yarn rebuild
VOLUME ["/var/cache/yarn"]
VOLUME ["/root/.cache"]
