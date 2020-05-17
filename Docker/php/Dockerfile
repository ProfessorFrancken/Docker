FROM composer:1.8.5 AS composer

FROM php:7.3.6-fpm

COPY --from=composer /usr/bin/composer /usr/bin/composer
# ENV COMPOSER_ALLOW_SUPERUSER 1

# https://olvlvl.com/2019-06-install-php-ext-source
# https://hub.docker.com/r/pickapp/pa-docker-php-fpm/~/dockerfile/
RUN apt-get update && apt-get install -y \
    zip \
    unzip \
    libzip-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libpq-dev \
    g++ \
    libicu-dev \
    libxml2-dev \
    libsqlite3-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    zlib1g-dev \
    libmagickwand-dev --no-install-recommends \
    ghostscript \
    procps

ENV EXT_REDIS_VERSION=4.3.0 \
    EXT_IGBINARY_VERSION=3.0.1 \
    EXT_APCU_VERSION=5.1.17 \
    EXT_IMAGICK_VERSION=3.4.4

RUN docker-php-source extract \
    # igbinary
    && mkdir -p /usr/src/php/ext/igbinary \
    &&  curl -fsSL https://github.com/igbinary/igbinary/archive/$EXT_IGBINARY_VERSION.tar.gz | tar xvz -C /usr/src/php/ext/igbinary --strip 1 \
    && docker-php-ext-install igbinary \
    # redis
    && mkdir -p /usr/src/php/ext/redis \
    && curl -fsSL https://github.com/phpredis/phpredis/archive/$EXT_REDIS_VERSION.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
    && docker-php-ext-configure redis --enable-redis-igbinary \
    && docker-php-ext-install redis \
    # apcu
    && mkdir -p /usr/src/php/ext/apcu \
    && curl -fsSL https://github.com/krakjoe/apcu/archive/v$EXT_APCU_VERSION.tar.gz | tar xvz -C /usr/src/php/ext/apcu --strip 1 \
    && docker-php-ext-install apcu \
    # imagick
    && mkdir -p /usr/src/php/ext/imagick \
    && curl -fsSL https://github.com/imagick/imagick/archive/$EXT_IMAGICK_VERSION.tar.gz | tar xvz -C /usr/src/php/ext/imagick --strip 1 \
    && docker-php-ext-install imagick \
    # && pecl install imagick  \
    # && docker-php-ext-enable imagick \
    # other extensions
    && docker-php-ext-configure intl \
    && docker-php-ext-install pdo_sqlite \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install zip \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install pdo_pgsql \
    && docker-php-ext-install soap \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install opcache \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install pcntl \
    # cleanup
    && docker-php-source delete

WORKDIR /var/www/francken
ADD php.ini /usr/local/etc/php/
ADD example.pool.conf /etc/php5/fpm/pool.d/

# RUN groupadd -g 33 www-data
# RUN useradd -u 33 -ms /bin/bash -g www-data www-data

RUN mkdir -p /home/www-data/
RUN chown www-data:www-data /home/www-data/
RUN usermod -d /home/www-data/ www-data
ENV XDG_CONFIG_HOME=/home/www-data/.config

USER www-data


CMD ["php-fpm", "-F"]
