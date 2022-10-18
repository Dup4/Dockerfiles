FROM golang:1.18-bullseye

ARG VERSION="v1.13.2"

USER root
WORKDIR /

RUN git clone https://github.com/hashicorp/consul.git -b ${VERSION} code && \
    cd code && \
    make linux && \
    ./pkg/bin/linux_$(go env GOARCH)/consul version && \
    rm -rf ./pkg

CMD ["bash"]
