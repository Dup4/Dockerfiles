ARG RUST_IMAGE_VERSION="1.68-bullseye"
FROM rust:${RUST_IMAGE_VERSION}

ARG VERSION="v2.2.1"

USER root
WORKDIR /root/
COPY ./bin /root/bin

ENV DEBIAN_FRONTEND noninteractive

RUN chmod +x /root/bin/*.sh \
    && VERSION=${VERSION} && bash /root/bin/install.sh

ENTRYPOINT ["/root/bin/docker_entry.sh"]
CMD ["primary"]
