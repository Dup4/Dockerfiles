#! /bin/bash

if [[ X"${1}" = X"primary" ]]; then
    mycli --help
elif [[ X"${1}" = X"bash" ]]; then
    exec bash
else
    exec mycli "$@"
fi
