# syntax=docker/dockerfile:latest
ARG version=latest
FROM dcr.bndigital.dev/library/yarn:${version}
WORKDIR /usr/local/src
COPY .yarn .yarn
COPY package.json yarn.lock .yarnrc.yml ./
RUN yarn
COPY . .
RUN yarn rebuild
