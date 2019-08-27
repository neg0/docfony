FROM nginx:1.17

LABEL maintainer = "Hadi Tajallaei"

RUN apt-get update -y && apt-get install -y \
    curl

RUN mkdir -p /var/www \
    && usermod -u 5000 www-data \
    && chown -R www-data:www-data /var/www

COPY nginx/default.conf /etc/nginx/conf.d/default.conf

VOLUME /var/www/

WORKDIR /var/www

HEALTHCHECK \
  --interval=1m \
  --timeout=3s \
  CMD ["/","http://0.0.0.0:80"]