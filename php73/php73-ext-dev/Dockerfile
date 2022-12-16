# TAG: labordigital/docker-base-images:php73-ext
# Build: docker build -t labordigital/docker-base-images:php73-ext .
# Push: docker push labordigital/docker-base-images:php73-ext

FROM labordigital/docker-base-images:php73-ext

FROM labordigital/docker-base-images:php73-dev

# Define author
MAINTAINER LABOR.digital <info@labor.digital>

# Set Label
LABEL description="LABOR Digital PHP7.3 Dev Edition - Extended"

# Run additional library installation
COPY --from=0 /opt/ext/build.sh /opt/ext/build.sh
RUN chmod +x /opt/ext/build.sh
RUN /opt/ext/build.sh