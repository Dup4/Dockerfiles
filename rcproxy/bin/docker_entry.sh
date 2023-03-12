#! /bin/bash

if [[ X"${1}" = X"primary" ]]; then
    exec /root/release/rcproxy /root/release/default.toml
elif [[ X"${1}" = X"bash" ]]; then
    exec bash
else
    exec /root/release/rcproxy "$@"
fi
