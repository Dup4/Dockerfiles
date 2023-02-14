#! /bin/bash

if [[ X"${1}" = X"primary" ]]; then
    pgcli --help
elif [[ X"${1}" = X"bash" ]]; then
    exec bash
else
    exec pgcli "$@"
fi
