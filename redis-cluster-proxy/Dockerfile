FROM debian:11 AS build

USER root
WORKDIR /

COPY ./install /install/

ENV DEBIAN_FRONTEND noninteractive

RUN apt update \
    && apt install --no-install-recommends --no-install-suggests -y git make gcc g++ \
    && apt clean \
    && git config --global http.sslverify false \
    && bash /install/install.sh \
    && rm -rf /install

ENTRYPOINT ["/docker_entry.sh"]
CMD ["primary"]

FROM debian:11

USER root
WORKDIR /

COPY --chown=root:root --from=build /usr/local/bin/redis-cluster-proxy /usr/local/bin/
COPY ./bin /

RUN chmod +x /*.sh

ENTRYPOINT ["/docker_entry.sh"]
CMD ["primary"]
