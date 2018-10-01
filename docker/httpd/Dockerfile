FROM httpd:2.4

LABEL maintainer = "Hadi Tajallaei"

RUN apt-get update -y && apt-get install -y libapache2-mod-fcgid

RUN mv /usr/lib/apache2/modules/mod_fcgid.so /usr/local/apache2/modules/mod_fcgid.so \
    && echo "# Loading FastCGI Module and CGI Proxy" >> /usr/local/apache2/conf/httpd.conf \
    && echo "LoadModule fcgid_module modules/mod_fcgid.so" >> /usr/local/apache2/conf/httpd.conf \
    && mv /usr/lib/apache2/modules/mod_proxy.so /usr/local/apache2/modules/mod_proxy.so \
    && echo "LoadModule proxy_module modules/mod_proxy.so" >> /usr/local/apache2/conf/httpd.conf \
    && mv /usr/lib/apache2/modules/mod_proxy_http.so /usr/local/apache2/modules/mod_proxy_http.so \
    && echo "LoadModule proxy_http_module modules/mod_proxy_http.so" >> /usr/local/apache2/conf/httpd.conf \
    && mv /usr/lib/apache2/modules/mod_proxy_fcgi.so /usr/local/apache2/modules/mod_proxy_fcgi.so \
    && echo "LoadModule proxy_fcgi_module modules/mod_proxy_fcgi.so" >> /usr/local/apache2/conf/httpd.conf \
    && echo "# Enabling Rewrite Module for Symfony htaccess" >> /usr/local/apache2/conf/httpd.conf \
    && echo "LoadModule rewrite_module modules/mod_rewrite.so" >> /usr/local/apache2/conf/httpd.conf

COPY httpd/symfony.conf /usr/local/apache2/conf/symfony.conf

RUN echo "# Symfony App Virtual Host" >>  /usr/local/apache2/conf/httpd.conf \
    && echo "Include conf/symfony.conf" >> /usr/local/apache2/conf/httpd.conf \
    && mkdir -p /var/www \
    && usermod -u 5000 www-data \
    && chown -R www-data:www-data /var/www

RUN ln -sf /dev/stdout /usr/local/apache2/logs/project_access.log \
    && ln -sf /dev/stderr /usr/local/apache2/logs/project_error.log

VOLUME /var/www