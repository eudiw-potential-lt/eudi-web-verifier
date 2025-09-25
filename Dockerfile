# Stage 1
FROM node:22 AS build-step

ARG BASE_HREF "/"
ARG API_URL "https://localhost:4200/"
ARG CONFIGURATION "production"
ARG APP_NAME "Verifier"

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY package.json /usr/src/app
COPY . /usr/src/app

RUN yarn install && \
    rm -rf dist && \
    yarn run build-docker && \
    rm -rf node_modules

# Stage 2
FROM nginx:alpine

ENV API_SERVER "localhost:4200"
ENV API_URL "https://${API_SERVER}"
ENV NGINX_PORT 4300
ENV NGINX_HOST localhost

COPY /nginx/templates/nginx.conf.template /etc/nginx/templates/default.conf.template
COPY --from=build-step /usr/src/app/dist/verifier-ui /site

EXPOSE $NGINX_PORT
