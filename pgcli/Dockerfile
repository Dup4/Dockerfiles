ARG PYTHON_IMAGE_VERSION=3.10

FROM python:${PYTHON_IMAGE_VERSION}

ARG VERSION=3.5.0

USER root
WORKDIR /
COPY ./bin /

ENV DEBIAN_FRONTEND noninteractive

RUN chmod +x /*.sh \
    && VERSION=${VERSION} && bash /install.sh

ENTRYPOINT ["/docker_entry.sh"]
CMD ["primary"]
