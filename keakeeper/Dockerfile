FROM alpine as builder
ARG KEAKEEPER_URL="https://ja.osdn.net/frs/redir.php?m=jaist&f=keakeeper%2F70242%2Fkeakeeper-1.03.tar.gz"
RUN apk add --update --no-cache curl \
    && mkdir -p /var/www \
    && curl -SL $KEAKEEPER_URL | tar -xzC /var/www \
    && addgroup -g 82 -S www-data \
    && adduser -u 82 -D -S -G www-data www-data \
    && chown -R www-data:www-data /var/www/keakeeper

FROM nginx:alpine as keahttpd
RUN apk add --update --no-cache tzdata
COPY --from=builder /var/www/keakeeper /var/www/keakeeper
COPY default.conf /etc/nginx/conf.d/

FROM php:8.3.0-fpm-alpine3.18 as keaphpfpm
RUN apk add --update --no-cache tzdata gettext \
    && apk add --update --no-cache --virtual .build-deps oniguruma-dev openssl-dev gettext-dev \
    && docker-php-ext-install pdo_mysql mysqli mbstring gettext \
    && apk del .build-deps
COPY --from=builder /var/www/keakeeper /var/www/keakeeper
COPY php.ini /usr/local/etc/php/
COPY application.ini /var/www/keakeeper/config/
