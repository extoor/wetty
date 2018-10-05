FROM node:8-alpine as build
WORKDIR /app
COPY . /app
RUN apk add --no-cache build-base python && \
    yarn && \
    yarn build && \
    yarn install --production --ignore-scripts --prefer-offline

FROM node:8-alpine
MAINTAINER "avp.ukr@gmail.com"
WORKDIR /app
ENV NODE_ENV=production
RUN apk add --no-cache openssh mc htop git curl zsh py3-pip && \
    pip3 install ipython && \
    adduser -D -h /home/term -s /bin/zsh term && \
    echo "term:term" | chpasswd
EXPOSE 3000
COPY --from=build /app /app
CMD ["yarn", "start"]
