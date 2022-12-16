# TAG: labordigital/docker-base-images:php73-ext
# Build: docker build -t labordigital/docker-base-images:php73-ext .
# Push: docker push labordigital/docker-base-images:php73-ext

FROM labordigital/docker-base-images:php73

# Define author
MAINTAINER LABOR.digital <info@labor.digital>

# Set Label
LABEL description="LABOR Digital PHP7.3 - Extended"

# Run additional library installation
COPY opt /opt
RUN chmod +x /opt/ext/build.sh
RUN /opt/ext/build.sh