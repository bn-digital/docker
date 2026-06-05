FROM node:20-alpine

WORKDIR /app

COPY package.json yarn.lock ./

# Change flag to --immutable if yarn v2
RUN yarn install --frozen-lockfile

COPY . .

RUN chown -R node:node /app

USER node

RUN yarn build

EXPOSE 3000

CMD ["yarn", "start"]