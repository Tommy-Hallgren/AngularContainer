### STAGE 1: Build ###
FROM node:14.17.0-alpine3.13 AS build

LABEL maintainer="tommy801008@gmail.com"

WORKDIR /usr/src/app

COPY package.json package-lock.json ./

RUN npm install

COPY . .

RUN npm run build

### STAGE 2: Run ###
FROM nginx:1.20.1-alpine

# experiment 
# RUN mkdir /usr/src/app
COPY --from=build /usr/src/app /usr/src/app

#--------------------------------------------

COPY nginx.conf /etc/nginx/nginx.conf
# COPY /usr/src/app/dist/AngularContainer /usr/share/nginx/html
# original
COPY --from=build /usr/src/app/dist/AngularContainer /usr/share/nginx/html