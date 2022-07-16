# syntax docker/dockerfile:latest
ARG unit_version=1.26.1
ARG php_version=8.1
ARG nodejs_version="18.6.0"
ARG os_version="alpine3.16"
FROM node:${nodejs_version}-${os_version} AS nodejs-base

FROM nodejs-base AS nodejs
LABEL org.opencontainers.image.authors="BN Enginseers" \
      org.opencontainers.image.url="https://github.com/bn-digital/docker" \
      org.opencontainers.image.source="https://github.com/bn-digital/docker" \
      org.opencontainers.image.vendor="BN Digital" \
      org.opencontainers.image.licenses="MIT"
ENV NODE_NO_WARNINGS=1
ENV HOST=0.0.0.0
ENV PORT=5000
ENV NODE_ENV=production
EXPOSE $PORT
RUN npm install --global serve
USER node
WORKDIR /usr/local/src
ONBUILD ENTRYPOINT ["serve"]
ONBUILD CMD ["--single", "."]
