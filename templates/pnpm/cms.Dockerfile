# syntax=docker/dockerfile:latest
FROM node:20-alpine AS base
RUN apk add --no-cache \
    build-base \
    cairo-dev \
    jpeg-dev \
    pango-dev \
    giflib-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    g++ \
    python3 \
    make

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable
RUN corepack prepare pnpm@9.15.1 --activate
COPY package.json pnpm-*.yaml .npmrc /app/
WORKDIR /app

FROM base AS prod-deps
COPY ./packages/cms/package.json /app/packages/cms/package.json
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --prod --frozen-lockfile
RUN pnpm deploy --filter=cms --prod /app/prune/node_modules

FROM base AS build
COPY ./packages/cms /app/packages/cms
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --frozen-lockfile
RUN pnpm run build

FROM base
COPY --from=build --chown=node:node /app/packages/cms /app
COPY --from=prod-deps --chown=node:node /app/prune/node_modules/node_modules /app/node_modules
EXPOSE 1337
ENV NODE_ENV=production
ENTRYPOINT ["node"]
CMD ["node_modules/@strapi/strapi/bin/strapi.js", "start"]