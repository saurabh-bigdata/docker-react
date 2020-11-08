# Phase 0: Build Phase
# -- does not work on AWS
# FROM node:alpine as builder
FROM node:alpine

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .

RUN ["npm", "run", "build"]

# Phase 1:
FROM nginx
# no impact locally but used in AWS EBS
EXPOSE 80
# COPY --from=builder /app/build /app -- does not work on AWS
COPY --from=0 /app/build /usr/share/nginx/html
# no need to start nginx as it's the default startup command of nginx image
