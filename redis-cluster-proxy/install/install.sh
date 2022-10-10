#! /bin/bash

TOP_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

cd "${TOP_DIR}" || exit 1

REDIS_CLUSTER_PROXY="redis-cluster-proxy"

git clone https://github.com/RedisLabs/redis-cluster-proxy.git "${REDIS_CLUSTER_PROXY}" -b 1.0

cd "${TOP_DIR}/${REDIS_CLUSTER_PROXY}" || exit 1

make
make install
