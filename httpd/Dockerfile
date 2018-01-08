FROM httpd:2.4

RUN apt-get update -y && apt-get install -y libapache2-mod-fcgid

RUN mv /usr/lib/apache2/modules/mod_fcgid.so /usr/local/apache2/modules/mod_fcgid.so \
    && echo "# Loading FastCGI Module and CGI Proxy" >> /usr/local/apache2/conf/httpd.conf \
    && echo "LoadModule fcgid_module modules/mod_fcgid.so" >> /usr/local/apache2/conf/httpd.conf \
    && mv /usr/lib/apache2/modules/mod_proxy.so /usr/local/apache2/modules/mod_proxy.so \
    && echo "LoadModule proxy_module modules/mod_proxy.so" >> /usr/local/apache2/conf/httpd.conf \
    && mv /usr/lib/apache2/modules/mod_proxy_http.so /usr/local/apache2/modules/mod_proxy_http.so \
    && echo "LoadModule proxy_http_module modules/mod_proxy_http.so" >> /usr/local/apache2/conf/httpd.conf \
    && mv /usr/lib/apache2/modules/mod_proxy_fcgi.so /usr/local/apache2/modules/mod_proxy_fcgi.so \
    && echo "LoadModule proxy_fcgi_module modules/mod_proxy_fcgi.so" >> /usr/local/apache2/conf/httpd.conf

COPY httpd/symfony.conf /usr/local/apache2/conf/symfony.conf

RUN echo "# Symfony App Virtual Host" >>  /usr/local/apache2/conf/httpd.conf \
    && echo "Include conf/symfony.conf" >> /usr/local/apache2/conf/httpd.conf \
    && mkdir -p /var/www \
    && usermod -u 5000 www-data \
    && chown -R www-data:www-data /var/www \
    && mkdir -p /var/log/apache2/

RUN ln -sf /dev/stdout /var/log/apache2/project_access.log \
	&& ln -sf /dev/stderr /var/log/apache2/project_error.log

VOLUME /var/www