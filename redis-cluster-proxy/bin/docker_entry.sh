#! /bin/bash

if [[ X"${1}" = X"bash" ]]; then
    exec bash
else
    exec redis-cluster-proxy "$@"
fi
