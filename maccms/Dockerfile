#
# Dockerfile for MACCMS
#

FROM php:7.4-apache

RUN set -ex \
    && apt-get update && apt-get install -y \
       git \
       unzip \
       libjpeg-dev \
       libzip-dev \
       libfreetype-dev \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install fileinfo \
    && docker-php-ext-install zip \
    && docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

ENV CMS_WWW_ROOT /var/www/html

RUN set -ex \
    && cd /tmp \
    && git clone https://github.com/magicblack/maccms10.git \
    && mv maccms10/* ${CMS_WWW_ROOT} \
    && cd ${CMS_WWW_ROOT} \
    && mv admin.php cmsadmin.php \
    && chmod a+rw -R application runtime upload static addons \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 80/tcp