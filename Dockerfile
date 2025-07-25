FROM node:20-alpine AS build
COPY . /app
WORKDIR /app
RUN npm ci
RUN npm run build

FROM node:20-alpine AS production
COPY ./package.json package-lock.json /app/
WORKDIR /app
RUN npm ci --omit=dev
COPY --from=build /app/build /app/build
CMD ["npm", "run", "start"]