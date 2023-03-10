FROM golang:1.19-bullseye

ARG VERSION="v1.14.3"

USER root
WORKDIR /

RUN git clone https://github.com/hashicorp/consul.git -b ${VERSION} code && \
    cd code && \
    make linux && \
    ./pkg/bin/linux_$(go env GOARCH)/consul version && \
    rm -rf ./pkg && \
    apt update && \
    apt install --no-install-recommends --no-install-suggests -y \
    lsof \
    iproute2 \
    telnet \
    iputils-ping \
    netcat \
    socat \
    dnsutils

CMD ["bash"]
