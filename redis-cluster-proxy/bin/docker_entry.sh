#! /bin/bash

if [[ X"${1}" = X"bash" ]]; then
    exec bash
elif [[ X"${1}" = X"redis-cluster-proxy" ]]; then
    exec "$@"
else
    exec redis-cluster-proxy "$@"
fi
