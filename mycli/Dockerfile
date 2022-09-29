FROM python:3.10

USER root
WORKDIR /
COPY ./bin /

ENV DEBIAN_FRONTEND noninteractive

RUN chmod +x /*.sh \
    && pip install mycli \
    && apt update \
    && apt install --no-install-recommends --no-install-suggests -y less \
    && apt clean

ENTRYPOINT ["/docker_entry.sh"]
CMD ["primary"]
