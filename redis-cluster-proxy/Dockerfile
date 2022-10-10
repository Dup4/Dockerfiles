FROM debian:11

USER root
WORKDIR /
COPY ./bin /

ENV DEBIAN_FRONTEND noninteractive

RUN chmod +x /*.sh \
    && bash /install.sh

ENTRYPOINT ["/docker_entry.sh"]
CMD ["primary"]
