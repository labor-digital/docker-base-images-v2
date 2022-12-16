#!/bin/bash

# Install imagick
apt-get update --fix-missing
apt-get install -y libmagickwand-dev --no-install-recommends
yes '' | sudo pecl install imagick || true
docker-php-ext-enable imagick
apt-get install -y imagemagick
apt-get install -y unzip

# Install SOAP extension
apt-get install -y libxml2-dev
docker-php-ext-install soap

# Install pdf2text for Search engine
apt-get install -y poppler-utils
