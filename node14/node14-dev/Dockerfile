# TAG: labordigital/docker-base-images:node14-dev
# Build: docker build -t labordigital/docker-base-images:node14-dev .
# Push: docker push labordigital/docker-base-images:node14-dev
FROM labordigital/docker-base-images-v2:node14

# Define author
MAINTAINER LABOR digital <info@labor.digital>

# Set Label
LABEL description="LABOR Digital Node14 Dev Edition"

ENV NODE_ENV development

# Install some global dependencies
RUN npm i -g nodemon npm-check-updates

# Add an extension to the bashrc to register the composer alias
COPY conf/bashrc-dev.sh /root/
RUN chmod +x /root/bashrc-dev.sh

# Add our additional scripts
COPY opt /opt
RUN find /opt/dev -type f -iname "*.sh" -exec chmod +x {} \;

ENV WRITE_PERMISSION_MARKERS=1
