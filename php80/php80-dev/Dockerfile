FROM labordigital/docker-base-images-v2:php80

MAINTAINER LABOR digital <info@labor.digital>
LABEL description="Labor Digital PHP8.0 Dev Edition"

COPY ssl/labor.systems/labor.systems.merged.crt /var/cert/merged.crt

# Install some packages we need in dev
RUN apt-get update && apt-get install -y \
		mariadb-client \
		git

# Install xdebug
COPY /conf/99-xdebug.ini /usr/local/etc/php/conf.d/
RUN yes | pecl install xdebug \
    && docker-php-ext-enable xdebug

# fix for apple silicon
RUN echo "" >> /etc/apache2/apache2.conf
RUN echo "Mutex posixsem" >> /etc/apache2/apache2.conf

# Add an extension to the bashrc to register the composer alias
COPY conf/bashrc-dev.sh /root/
RUN chmod +x /root/bashrc-dev.sh

COPY /conf/99-environment.ini /usr/local/etc/php/conf.d/
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin
RUN source /root/.bashrc \
	&& ensure_dir /var/www/.composer

COPY opt /opt
RUN find /opt/dev -type f -iname "*.sh" -exec chmod +x {} \;
ENV WRITE_PERMISSION_MARKERS=1