# TAG: labordigital/docker-base-images:php72-legacy-dev
# Build: docker build -t labordigital/docker-base-images:php72-legacy-dev .
# Push: docker push labordigital/docker-base-images:php72-legacy-dev
FROM labordigital/docker-base-images-v2:php72-legacy

# Define author
MAINTAINER LABOR digital <info@labor.digital>

# Set Label
LABEL description="Labor Digital PHP7.2 Dev Edition - LEGACY"

COPY ssl/localmachine.space/localmachine.space.merged.crt /var/cert/merged.crt

# Install some packages we need in dev
RUN apt-get update && apt-get install -y \
		mariadb-client \
		git

# Setup a composer user
RUN groupadd composer
RUN adduser composer --disabled-login --disabled-password --home /home/composer --ingroup composer --gecos ""
RUN usermod -a -G www-data composer

# Setup a root bashrc for the composer-alias
COPY conf/.bashrc /root/

# Add development configuration
COPY /conf/99-environment.ini /usr/local/etc/php/conf.d/

# Configure composer
RUN mkdir /home/composer/.composer
COPY conf/composer.json /home/composer/.composer/composer.json
RUN chown -R composer.composer /home/composer/.composer

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin \
    && mv /usr/local/bin/composer.phar /usr/local/bin/composer2.phar

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --1

# Install dev symlinker
RUN sudo -u composer -EH /usr/local/bin/composer.phar global install

# Add phpunit
RUN apt-get update && apt-get install -y wget \
	&& wget "https://phar.phpunit.de/phpunit-6.0.phar" \
	&& chmod +x "phpunit-6.0.phar" \
	&& mv "phpunit-6.0.phar" /usr/local/bin/phpunit \
	&& phpunit --version

# Copy bootstrap-dev.sh
COPY opt/bootstrap-dev.sh /opt/bootstrap-dev.sh
RUN chmod +x /opt/bootstrap-dev.sh

# Copy bootstrap.sh
COPY opt/bootstrap.sh /opt/bootstrap.sh
RUN chmod +x /opt/bootstrap.sh

# Copy directories.sh
COPY opt/directories.sh /opt/directories.sh
RUN chmod +x /opt/directories.sh