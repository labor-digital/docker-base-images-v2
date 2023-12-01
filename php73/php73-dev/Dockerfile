# TAG: labordigital/docker-base-images:php73-dev
# Build: docker build -t labordigital/docker-base-images:php73-dev .
# Push: docker push labordigital/docker-base-images:php73-dev
FROM labordigital/docker-base-images-v2:php73

# Define author
MAINTAINER LABOR digital <info@labor.digital>

# Set Label
LABEL description="Labor Digital PHP7.3 Dev Edition"

COPY ssl/labor.systems/labor.systems.merged.crt /var/cert/merged.crt

# Install some packages we need in dev
RUN apt-get update && apt-get install -y \
		mariadb-client \
		git

# Add an extension to the bashrc to register the composer alias
COPY conf/bashrc-dev.sh /root/
RUN chmod +x /root/bashrc-dev.sh

# fix for apple silicon
RUN echo "" >> /etc/apache2/apache2.conf
RUN echo "Mutex posixsem" >> /etc/apache2/apache2.conf

# Add development configuration
COPY /conf/99-environment.ini /usr/local/etc/php/conf.d/

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin \
    && mv /usr/local/bin/composer.phar /usr/local/bin/composer2.phar

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --1

# Add our additional scripts
COPY opt /opt
RUN find /opt/dev -type f -iname "*.sh" -exec chmod +x {} \;

# Make composer home directory
RUN source /root/.bashrc \
	&& ensure_dir /var/www/.composer

ENV WRITE_PERMISSION_MARKERS=1