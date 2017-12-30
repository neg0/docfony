FROM php:7.1-fpm AS dev

LABEL licence = "MIT"
LABEL maintainer = "Hadi Ta"

RUN apt-get update -y && apt-get install -y \
    git \
    unzip \
    libsasl2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libicu-dev \
    librabbitmq-dev \
    libxrender1 \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libxml2-dev \
    libfontconfig1 \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install soap \
    && docker-php-ext-install pdo mysql_pdo \
    && docker-php-ext-install intl \
    && docker-php-ext-install zip

RUN pecl update-channels \
    && pecl install mongodb-1.3.4 \
    && echo "extension=mongodb.so" >> /usr/local/etc/php/conf.d/mongodb-docker-php-ext.ini \
    && pecl install apcu-5.1.8 \
    && echo "extension=apcu.so" >> /usr/local/etc/php/conf.d/apcu-docker-php-ext.ini \
    && pecl install amqp-1.9.3 \
    && echo "extension=amqp.so" >> /usr/local/etc/php/conf.d/amqp-docker-php-ext.ini \
    && pecl install xdebug-2.5.5

COPY php/xdebug.ini /usr/local/etc/php/conf.d/xdebug-docker-php-ext.ini

COPY php/php.ini /usr/local/etc/php/

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer --version

RUN chown -R www-data:www-data /var/www

WORKDIR /var/www