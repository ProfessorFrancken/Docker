FROM php:7.0.7-cli

RUN docker-php-ext-install pdo_mysql

# RUN apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS \
#     && pecl install xdebug-2.4.0 \
#     && docker-php-ext-enable xdebug \
#     && apk del .phpize-deps

RUN pecl install xdebug-2.4.0 \
    && docker-php-ext-enable xdebug

ADD ./php.ini /usr/local/etc/php/conf.d

CMD ["vendor/bin/phpunit", "--coverage-text"]
