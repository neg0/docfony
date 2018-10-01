FROM nginx:1.15

LABEL maintainer = "Hadi Tajallaei"

RUN mkdir -p /var/www \
    && usermod -u 5000 www-data \
    && chown -R www-data:www-data /var/www

COPY nginx/default.conf /etc/nginx/conf.d/default.conf

VOLUME /var/www/

WORKDIR /var/www