# syntax docker/dockerfile:latest
ARG nodejs_version=18
ARG os_version="bullseye-slim"
FROM node:${nodejs_version}-${os_version} AS build
LABEL org.opencontainers.image.authors="BN Enginseers" \
      org.opencontainers.image.vendor="BN Digital" \
      org.opencontainers.image.title="NodeJS" \
      org.opencontainers.image.url="https://github.com/bn-digital/docker" \
      org.opencontainers.image.base.name="dcr.bndigital.dev/library/nodejs" \
      org.opencontainers.image.source="https://github.com/bn-digital/docker" \
      org.opencontainers.image.licenses="MIT"
ENV NODE_NO_WARNINGS="1" \
    HOST="0.0.0.0" \
    PORT="5000" \
    NODE_ENV=production
WORKDIR /usr/local/src
RUN npm install --global pm2
USER node
EXPOSE $PORT
COPY --chown=node . .
ENTRYPOINT ["pm2-runtime"]
CMD ["--json", "process.yml"]

FROM build
