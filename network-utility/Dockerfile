FROM debian:11

USER root
WORKDIR /root/

ENV DEBIAN_FRONTEND noninteractive

RUN apt update \
    && apt install --no-install-recommends --no-install-suggests -y \
    openssh-client \
    ca-certificates \
    gnupg2 \
    iproute2 \
    lsof \
    net-tools \
    telnet \
    iputils-ping \
    netcat \
    socat \
    dnsutils \
    curl \
    wget \
    less \
    vim \
    jq \
    locales \
    sudo \
    man \
    manpages \
    manpages-dev \
    && apt clean

CMD ["/bin/bash"]
