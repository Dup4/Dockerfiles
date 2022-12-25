FROM ubuntu:22.04

ARG VERSION=15

USER root
WORKDIR /

ENV DEBIAN_FRONTEND noninteractive

RUN apt update \
    && apt install --no-install-recommends --no-install-suggests -y \
    wget \
    ca-certificates \
    lsb-release \
    software-properties-common \
    gnupg \
    && apt clean \
    && wget https://apt.llvm.org/llvm.sh \
    && bash llvm.sh ${VERSION} all \
    && rm llvm.sh

CMD ["bash"]
