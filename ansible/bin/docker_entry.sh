#! /bin/bash

if [[ X"${1}" = X"primary" ]]; then
    ansible --help
elif [[ X"${1}" = X"bash" ]]; then
    exec bash
else
    exec ansible "$@"
fi
