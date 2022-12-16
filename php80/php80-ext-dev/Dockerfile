ARG BASE_TAG

FROM labordigital/docker-base-images:${BASE_TAG}-ext
FROM labordigital/docker-base-images:${BASE_TAG}-dev

MAINTAINER LABOR.digital <info@labor.digital>
LABEL description="LABOR Digital ${BASE_TAG} Dev Edition - Extended"

COPY --from=0 /opt/ext/build.sh /opt/ext/build.sh
RUN chmod +x /opt/ext/build.sh
RUN /opt/ext/build.sh