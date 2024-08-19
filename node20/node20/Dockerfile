FROM node:20-bullseye

# Define author
MAINTAINER LABOR.digital <info@labor.digital>

# Set Label
LABEL description="LABOR Digital Node20"

# Expose ports
EXPOSE 8000

# Set console to xterm to fix problems with nano and other console comands in pseudo-TTY connections
# @see http://stackoverflow.com/questions/27826241/running-nano-in-docker-container
ENV TERM=xterm

# Install sudo
RUN apt-get update && apt-get install -y sudo
RUN apt-get update && apt-get install -y vim nano

# Configure dpkg | Install locales, keyboard and timezone
COPY /conf/deb-preseed.txt /tmp/init_locales/deb-preseed.txt
RUN DEBIAN_FRONTEND=noninteractive \
	DEBCONF_NONINTERACTIVE_SEEN=true \
	debconf-set-selections /tmp/init_locales/deb-preseed.txt \
	&& apt-get update && apt-get install -y \
        locales \
	&& echo "Europe/Berlin" > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata \
    && dpkg-reconfigure -f noninteractive locales \
	&& rm -rf /tmp/init_locales
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

ENV NODE_ENV production

# Install curl
RUN apt-get install -y \
		curl \
		libcurl4-gnutls-dev

# Install zip extension
RUN apt-get install -y \
        libzip-dev \
        zip

# Install doppler
RUN export HISTIGNORE='doppler*'
RUN apt-get install -y apt-transport-https ca-certificates gnupg \
  && curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key' | apt-key add - \
  && echo "deb https://packages.doppler.com/public/cli/deb/debian any-version main" | tee /etc/apt/sources.list.d/doppler-cli.list \
  && apt-get update \
  && apt-get install doppler -y

# Setup a root bashrc for the composer-alias
COPY conf/.bashrc /root/

# Use bash as our default shell
SHELL ["/bin/bash", "-c"]

# Add our scripts
COPY opt /opt
RUN find /opt -type f -iname "*.sh" -exec chmod +x {} \;

# Create data and logs directory and set the correct folder permissions
RUN source /root/.bashrc \
	&& ensure_dir /var/www/html_data \
	&& ensure_dir /var/www/html \
	&& ensure_dir /var/www/logs

# Prepare default work directory
COPY src/* /var/www/html/
WORKDIR /var/www/html

CMD ["doppler", "run", "--", "/opt/bootstrap.sh"]
