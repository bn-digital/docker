# syntax docker/dockerfile:latest
ARG unit_version=1.25.0
ARG nodejs_version=16.13.0
ARG php_version=8.0
FROM node:${nodejs_version}-slim AS nodejs-base

FROM nodejs-base AS nodejs-build
LABEL maintainer="NGINX Docker Maintainers <docker-maint@nginx.com>"
RUN set -ex \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y ca-certificates mercurial build-essential libssl-dev libpcre2-dev \
    && mkdir -p /usr/lib/unit/modules /usr/lib/unit/debug-modules \
    && hg clone https://hg.nginx.org/unit \
    && cd unit \
    && hg up 1.25.0 \
    && NCPU="$(getconf _NPROCESSORS_ONLN)" \
    && DEB_HOST_MULTIARCH="$(dpkg-architecture -q DEB_HOST_MULTIARCH)" \
    && CC_OPT="$(DEB_BUILD_MAINT_OPTIONS="hardening=+all,-pie" DEB_CFLAGS_MAINT_APPEND="-Wp,-D_FORTIFY_SOURCE=2 -fPIC" dpkg-buildflags --get CFLAGS)" \
    && LD_OPT="$(DEB_BUILD_MAINT_OPTIONS="hardening=+all,-pie" DEB_LDFLAGS_MAINT_APPEND="-Wl,--as-needed -pie" dpkg-buildflags --get LDFLAGS)" \
    && CONFIGURE_ARGS="--prefix=/usr \
                --state=/var/lib/unit \
                --control=unix:/var/run/control.unit.sock \
                --pid=/var/run/unit.pid \
                --log=/var/log/unit.log \
                --tmp=/var/tmp \
                --user=unit \
                --group=unit \
                --openssl \
                --libdir=/usr/lib/$DEB_HOST_MULTIARCH" \
    && ./configure $CONFIGURE_ARGS --cc-opt="$CC_OPT" --ld-opt="$LD_OPT" --modules=/usr/lib/unit/debug-modules --debug \
    && make -j $NCPU unitd \
    && install -pm755 build/unitd /usr/sbin/unitd-debug \
    && make clean \
    && ./configure $CONFIGURE_ARGS --cc-opt="$CC_OPT" --ld-opt="$LD_OPT" --modules=/usr/lib/unit/modules \
    && make -j $NCPU unitd \
    && install -pm755 build/unitd /usr/sbin/unitd \
    && make clean \
    && ./configure $CONFIGURE_ARGS --cc-opt="$CC_OPT" --modules=/usr/lib/unit/debug-modules --debug \
    && ./configure nodejs --node-gyp=/usr/local/lib/node_modules/npm/bin/node-gyp-bin/node-gyp \
    && make -j $NCPU node node-install libunit-install \
    && make clean \
    && ./configure $CONFIGURE_ARGS --cc-opt="$CC_OPT" --modules=/usr/lib/unit/modules \
    && ./configure nodejs --node-gyp=/usr/local/lib/node_modules/npm/bin/node-gyp-bin/node-gyp \
    && make -j $NCPU node node-install libunit-install \
    && ldd /usr/sbin/unitd | awk '/=>/{print $(NF-1)}' | while read n; do dpkg-query -S $n; done | sed 's/^\([^:]\+\):.*$/\1/' | sort | uniq > /requirements.apt



FROM nginx/unit:${unit_version}-node15 AS nodejs-nginx
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


FROM nodejs-base AS nodejs
LABEL org.opencontainers.image.authors="BN Enginseers" \
      org.opencontainers.image.url="https://github.com/bn-digital/docker" \
      org.opencontainers.image.source="https://github.com/bn-digital/docker" \
      org.opencontainers.image.vendor="BN Digital" \
      org.opencontainers.image.licenses="MIT"
RUN npm install --global serve
SHELL ["/bin/sh", "-c"]
ENTRYPOINT ["serve"]
CMD ["--single", "."]
ENV HOST=127.0.0.1
ENV PORT=5000
ENV NODE_ENV=production
EXPOSE 5000
ONBUILD USER node
ONBUILD WORKDIR /usr/local/src


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
