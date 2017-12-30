FROM nginx:1.13.8 AS dev

LABEL licence = "MIT"
LABEL maintainer = "Hadi Ta"

RUN mkdir -p /var/www \
    && usermod -u 5000 www-data \
    && chown -R www-data:www-data /var/www

COPY nginx/default.conf /etc/nginx/conf.d/default.conf

VOLUME /var/www/

WORKDIR /var/www