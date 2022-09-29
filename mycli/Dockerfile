FROM python:3.10

USER root
WORKDIR /
COPY ./ /

ENV DEBIAN_FRONTEND noninteractive

RUN pip install mycli

ENTRYPOINT ["/docker_entry.sh"]
CMD ["primary"]
