#! /bin/bash

if [[ X"${1}" = X"primary" ]]; then
    redis-cli --help
elif [[ X"${1}" = X"bash" ]]; then
    exec bash
else
    exec redis-cli "$@"
fi
