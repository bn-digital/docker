FROM node:22-alpine AS base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable
RUN corepack prepare pnpm@9.15.1 --activate
# Adjust directory
COPY package.json pnpm-*.yaml /app/
WORKDIR /app

FROM base AS build
# Adjust directory
COPY ./packages/web /app/packages/web
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --frozen-lockfile
RUN pnpm run build

FROM nginxinc/nginx-unprivileged:latest
USER root
WORKDIR /usr/app
# Adjust directory
COPY ./packages/web/nginx/default.conf /etc/nginx/conf.d/default.conf
USER nginx
# Adjust directory
COPY --from=build /app/packages/web/build /usr/share/nginx/html
EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]