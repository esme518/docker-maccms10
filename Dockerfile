#
# Dockerfile for MACCMS
#

FROM php:7.4-apache

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

ENV WWW_ROOT /var/www/html
ENV REPO_URL https://github.com/magicblack/maccms10.git

RUN set -ex \
    && cd /tmp \
    && git clone ${REPO_URL} \
    && mv maccms10/* ${WWW_ROOT} \
    && rm -rf /tmp/maccms10 \
    && cd ${WWW_ROOT} \
    && mv admin.php cmsadmin.php \
    && chmod a+rw -R application runtime upload static addons \
    && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

EXPOSE 80/tcp
