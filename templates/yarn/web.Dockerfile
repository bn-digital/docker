FROM node:22-alpine AS base
# Adjust directory
COPY package.json yarn.lock /app/
WORKDIR /app

FROM base AS build
# Adjust directory
COPY ./packages/web /app/packages/web
# Change flag to --immutable if yarn v2
RUN yarn install --frozen-lockfile
RUN yarn build

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