FROM nginx:1.17

LABEL maintainer = "Hadi Tajallaei"

RUN apt-get update -y && apt-get install -y \
    curl

RUN mkdir -p /var/www \
    && usermod -u 5000 www-data \
    && chown -R www-data:www-data /var/www

COPY nginx/default.conf /etc/nginx/conf.d/default.conf

RUN mkdir -p /var/http/health_check \
    && usermod -u 5000 www-data \
    && chown -R www-data:www-data /var/http/health_check

COPY php/config/health.php /var/http/health_check/index.php
VOLUME /var/http/health_check

EXPOSE 8090

HEALTHCHECK \
  --interval=1m \
  --timeout=10s \
  CMD curl -f http://localhost:8090 || exit 1


VOLUME /var/www/

WORKDIR /var/www