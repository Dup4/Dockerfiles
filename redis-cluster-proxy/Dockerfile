FROM debian:11

USER root
WORKDIR /

COPY ./bin /
COPY ./install /install/

ENV DEBIAN_FRONTEND noninteractive

RUN apt update \
    && apt install --no-install-recommends --no-install-suggests -y git make gcc \
    && apt clean \
    && git config --global http.sslverify false \
    && bash /install/install.sh \
    && rm -rf /install

ENTRYPOINT ["/docker_entry.sh"]
CMD ["primary"]
