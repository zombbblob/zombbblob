FROM node:lts-alpine

# Dependencies for building node-gyp packages
RUN apk add python3 make g++

WORKDIR /app

COPY . .

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 zombbbot
RUN chown -R zombbbot:nodejs /app

USER zombbbot
RUN npm ci
RUN npm run build
RUN npm install --omit-dev

CMD ["node", "build/index.js"]
