ARG PYTHON_IMAGE_VERSION=3.11

FROM python:${PYTHON_IMAGE_VERSION}

ARG VERSION=7.4.0

USER root
WORKDIR /
COPY ./bin /

ENV DEBIAN_FRONTEND noninteractive

RUN chmod +x /*.sh \
    && VERSION=${VERSION} && bash /install.sh \
    && apt install -y sshpass

ENTRYPOINT ["/docker_entry.sh"]
CMD ["primary"]
