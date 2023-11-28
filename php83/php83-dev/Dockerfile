ARG BASE_TAG

FROM labordigital/docker-base-images-v2:${BASE_TAG}

MAINTAINER LABOR digital <info@labor.digital>
LABEL description="Labor Digital ${BASE_TAG} Dev Edition"

COPY ssl/localmachine.space/localmachine.space.merged.crt /var/cert/merged.crt

# Install some packages we need in dev
RUN apt-get update && apt-get install -y \
		mariadb-client \
		git

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