# syntax docker/dockerfile:latest
ARG php_version=8.1
ARG nodejs_version="18"
ARG os_version="bullseye-slim"
FROM node:${nodejs_version}-${os_version}
LABEL org.opencontainers.image.authors="BN Enginseers" \
      org.opencontainers.image.vendor="BN Digital" \
      org.opencontainers.image.title="NodeJS" \
      org.opencontainers.image.url="https://github.com/bn-digital/docker" \
      org.opencontainers.image.base.name="dcr.bndigital.dev/library/nodejs" \
      org.opencontainers.image.source="https://github.com/bn-digital/docker" \
      org.opencontainers.image.licenses="MIT"
ENV NODE_NO_WARNINGS=1
ENV HOST=0.0.0.0
ENV PORT=5000
ENV NODE_ENV=production
EXPOSE $PORT
RUN npm install --location=global \
     serve \
     npm
USER node
WORKDIR /usr/local/src
ONBUILD ENTRYPOINT ["serve"]
ONBUILD CMD ["--single", "--no-etag", "."]
