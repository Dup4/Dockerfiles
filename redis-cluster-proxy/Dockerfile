FROM debian:11

USER root
WORKDIR /
COPY ./bin /
COPY ./install /install

ENV DEBIAN_FRONTEND noninteractive

RUN chmod +x /*.sh \
    && bash /insall/install.sh \
    && rm -rf /install

ENTRYPOINT ["/docker_entry.sh"]
CMD ["primary"]
