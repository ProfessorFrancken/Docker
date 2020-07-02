FROM composer:2.0 AS composer

FROM php:7.4.7-fpm

COPY --from=composer /usr/bin/composer /usr/bin/composer

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/

RUN install-php-extensions gd redis igbinary apcu imagick \
    intl zip pdo_mysql pdo_pgsql soap opcache mysqli bcmath pcntl \
    pdo_sqlite mbstring

# RUN install-php-extensions xdebug pcov

WORKDIR /var/www/francken
ADD php.ini /usr/local/etc/php/
ADD example.pool.conf /etc/php5/fpm/pool.d/

# RUN groupadd -g 33 www-data
# RUN useradd -u 33 -ms /bin/bash -g www-data www-data

# RUN mkdir -p /home/www-data/
# RUN chown www-data:www-data /home/www-data/
# RUN usermod -d /home/www-data/ www-data
# ENV XDG_CONFIG_HOME=/home/www-data/.config

# USER www-data

CMD ["php-fpm", "-F"]
