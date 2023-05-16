# syntax=docker/dockerfile:1
ARG version=3.6.1
FROM dcr.bndigital.dev/library/yarn:${version}
WORKDIR /usr/local/src
COPY . .
RUN yarn
