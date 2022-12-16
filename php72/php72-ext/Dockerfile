# TAG: labordigital/docker-base-images:php72-ext
# Build: docker build -t labordigital/docker-base-images:php72-ext .
# Push: docker push labordigital/docker-base-images:php72-ext

FROM labordigital/docker-base-images-v2:php72

# Define author
MAINTAINER LABOR.digital <info@labor.digital>

# Set Label
LABEL description="LABOR Digital PHP7.2 - Extended"

# Run additional library installation
COPY opt /opt
RUN chmod +x /opt/ext/build.sh
RUN /opt/ext/build.sh