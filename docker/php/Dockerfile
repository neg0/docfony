FROM php:7.4-rc-fpm-buster

LABEL maintainer = "Hadi Tajallaei"

RUN apt-get update -y && apt-get install -y \
    apt-utils \
    git \
    unzip \
    libsasl2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libicu-dev \
    libxrender1 \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libxml2-dev \
    libfontconfig1 \
    libc6 \
    libgcc1 \
    libsodium-dev \
    libbz2-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install bz2 \
    && docker-php-ext-install opcache \
    && docker-php-ext-install intl \
    && docker-php-ext-install zip \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install sodium

RUN pecl update-channels \
    && pecl install mongodb-1.5.5 \
    && echo "extension=mongodb.so" >> /usr/local/etc/php/conf.d/docker-php-ext-mongodb.ini \
    && pecl install apcu-5.1.17	\
    && echo "extension=apcu.so" >> /usr/local/etc/php/conf.d/docker-php-ext-apcu.ini \
    && pecl install xdebug-2.8.0beta2

COPY php/config/xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

COPY php/config/php.ini /usr/local/etc/php/

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer --version

RUN chown -R www-data:www-data /var/www

WORKDIR /var/www