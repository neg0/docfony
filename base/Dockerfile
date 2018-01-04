FROM php:7.2-fpm AS dev

LABEL licence = "MIT"
LABEL maintainer = "Hadi Tajallaei"

RUN apt-get update -y && apt-get install -y \
    apt-utils \
    git \
    unzip

RUN chown -R www-data:www-data /var/www

WORKDIR /var/www