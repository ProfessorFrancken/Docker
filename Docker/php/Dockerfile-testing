FROM francken/php

ADD php-testing.ini /usr/local/etc/php/php.ini

RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Install git so that we can use coveralls
RUN apt-get update \
    && apt-get install -y git \
    && rm -rf /var/lib/apt

CMD ["vendor/bin/phpunit", "--coverage-text"]
