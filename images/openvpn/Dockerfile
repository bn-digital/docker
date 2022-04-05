FROM alpine:3.15.4
LABEL org.opencontainers.image.authors="BN Enginseers <dev@bndigital.co>" \
      org.opencontainers.image.url="https://github.com/bn-digital/docker" \
      org.opencontainers.image.source="https://github.com/bn-digital/docker" \
      org.opencontainers.image.vendor="BN Digital" \
      org.opencontainers.image.licenses="MIT"
RUN echo "https://dl-4.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories \
 && echo "https://dl-4.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories \
 && apk update \
 && apk upgrade \
 && apk add \
      openssl \
      easy-rsa \
      openvpn \
      iptables \
      bash \
 && rm -rf \
      /tmp/* \
      /var/tmp/* \
      /var/cache/apk/* \
      /var/cache/distfiles/* \
 && mkdir -p /dev/net \
 && mknod /dev/net/tun c 10 200
SHELL ["/bin/bash", "-c"]
