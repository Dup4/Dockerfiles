ARG REDIS_IMAGE_VERSION=7.0

FROM python:${REDIS_IMAGE_VERSION}

USER root
WORKDIR /
COPY ./bin /

ENV DEBIAN_FRONTEND noninteractive

RUN chmod +x /*.sh \
    && VERSION=${VERSION} && bash /install.sh

ENTRYPOINT ["/docker_entry.sh"]
CMD ["primary"]
