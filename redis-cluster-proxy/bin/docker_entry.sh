#! /bin/bash

if [[ X"${1}" = X"bash" ]]; then
    exec bash
else
    CMD="$*"
    ARGS=${CMD#"redis-cluster-proxy"}

    exec redis-cluster-proxy "${ARGS}"
fi
