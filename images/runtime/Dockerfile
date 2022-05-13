# syntax docker/dockerfile:latest
ARG unit_version=1.26.1
ARG nodejs_version=18
ARG php_version=8.1
ARG os_version=bullseye-slim
FROM node:${nodejs_version}-${os_version} AS nodejs-base

FROM nginx/unit:${unit_version}-node16 AS nodejs-nginx
RUN apt-get update \
 && apt-get upgrade --yes \
 && apt-get dist-upgrade --yes \
 && apt-get install --no-install-recommends --no-install-suggests --yes curl $(cat /requirements.apt) \
 && apt-get clean \
 && apt-get autoremove \
 && apt-get purge \
 && rm -rf /var/lib/apt/lists/* \
 && rm -f /requirements.apt \
 && ln -sf /dev/stdout /var/log/unit.log
ENV NODE_NO_WARNINGS=1
ENV PORT=5000
ENV NODE_ENV=production
COPY docker-entrypoint.d/nodejs.json /docker-entrypoint.d/unit.json

FROM nginx/unit:${unit_version}-minimal AS static-nginx
LABEL org.opencontainers.image.authors="BN Enginseers" \
      org.opencontainers.image.url="https://github.com/bn-digital/docker" \
      org.opencontainers.image.source="https://github.com/bn-digital/docker" \
      org.opencontainers.image.vendor="BN Digital" \
      org.opencontainers.image.licenses="MIT"
ENV NODE_NO_WARNINGS=1
ENV PORT=5000
ENV NODE_ENV=production
COPY docker-entrypoint.d/html.json /docker-entrypoint.d/unit.json

FROM nodejs-base AS nodejs
LABEL org.opencontainers.image.authors="BN Enginseers" \
      org.opencontainers.image.url="https://github.com/bn-digital/docker" \
      org.opencontainers.image.source="https://github.com/bn-digital/docker" \
      org.opencontainers.image.vendor="BN Digital" \
      org.opencontainers.image.licenses="MIT"
SHELL ["/bin/sh", "-c"]
ENV NODE_NO_WARNINGS=1
ENV HOST=0.0.0.0
ENV PORT=5000
ENV NODE_ENV=production
EXPOSE 5000
ONBUILD RUN npm install --global serve
ONBUILD USER node
ONBUILD WORKDIR /usr/local/src
ONBUILD ENTRYPOINT ["serve"]
ONBUILD CMD ["--single", "."]


FROM nginx/unit:${unit_version}-php${php_version} AS php-nginx
LABEL org.opencontainers.image.authors="BN Enginseers" \
      org.opencontainers.image.url="https://github.com/bn-digital/docker" \
      org.opencontainers.image.vendor="BN Digital" \
      org.opencontainers.image.licenses="MIT"
RUN apt-get update \
 && apt-get install -y \
      libfreetype6-dev \
      libjpeg62-turbo-dev \
      libpng-dev \
      libzip-dev \
 && docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install -j$(nproc) \
      gd \
      zip
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
COPY docker-entrypoint.d/php.json /docker-entrypoint.d/unit.json
WORKDIR /usr/local/src
EXPOSE 8000
