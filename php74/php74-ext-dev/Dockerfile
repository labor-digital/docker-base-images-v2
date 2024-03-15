# TAG: labordigital/docker-base-images-v2:php74-dev
# Build: docker build -t labordigital/docker-base-images-v2:php74-dev .
# Push: docker push labordigital/docker-base-images-v2:php74-dev
FROM labordigital/docker-base-images-v2:php74-ext

FROM labordigital/docker-base-images-v2:php74-dev

# Define author
MAINTAINER LABOR digital <info@labor.digital>

# Set Label
LABEL description="LABOR Digital PHP7.4 - Extended Dev"

# Run additional library installation
COPY --from=0 /opt/ext/build.sh /opt/ext/build.sh
RUN chmod +x /opt/ext/build.sh
RUN /opt/ext/build.sh