FROM golang:1.19-bullseye

ARG VERSION="v1.14.3"

USER root
WORKDIR /

ENV DEBIAN_FRONTEND noninteractive

RUN git clone https://github.com/hashicorp/consul.git -b ${VERSION} code \
    && cd code \
    && make linux \
    && ./pkg/bin/linux_$(go env GOARCH)/consul version \
    && rm -rf ./pkg

CMD ["bash"]
