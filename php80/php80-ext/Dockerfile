ARG BASE_TAG

FROM labordigital/docker-base-images:${BASE_TAG}

MAINTAINER LABOR.digital <info@labor.digital>
LABEL description="LABOR Digital ${BASE_TAG} - Extended"

COPY opt /opt
RUN chmod +x /opt/ext/build.sh
RUN /opt/ext/build.sh