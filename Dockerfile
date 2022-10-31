#
# Dockerfile for MACCMS
#

FROM php:7.4-apache

COPY docker-entrypoint.sh /entrypoint.sh

ENV REPO_URL https://github.com/magicblack/maccms10.git

RUN set -ex \
    && apt-get update && apt-get install -y \
       git \
       unzip \
       libfreetype-dev \
       libjpeg-dev \
       libwebp-dev \
       libzip-dev \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install fileinfo \
    && docker-php-ext-install zip \
    && docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
        --with-webp \
    && docker-php-ext-install -j$(nproc) gd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN set -ex \
    && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    && echo "ServerName localhost" >> /etc/apache2/apache2.conf

VOLUME /var/www/html

ENV ADMIN_PHP cmsadmin.php

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]