#! /bin/bash

if [[ X"${1}" = X"bash" ]]; then
    exec bash
else
    CMD="$*"
    ARGS=${CMD#"redis-cluster-proxy"}

    # shellcheck disable=SC2086
    exec redis-cluster-proxy ${ARGS}
fi
