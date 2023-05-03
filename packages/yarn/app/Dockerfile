# syntax=docker/dockerfile:1
ARG version=3.5.0
FROM dcr.bndigital.dev/library/yarn:${version}
WORKDIR /usr/local/src
COPY .yarn .yarn
COPY package.json yarn.lock .yarnrc.yml ./
RUN --mount=type=cache,target=/var/cache/yarn \
      yarn
COPY . .
RUN yarn rebuild
