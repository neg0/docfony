FROM docfony:base AS dev

LABEL licence = "MIT"
LABEL maintainer = "Hadi Tajallaei"

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer --version

WORKDIR /var/www