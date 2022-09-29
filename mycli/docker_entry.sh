#! /bin/sh

if [ X"${1}" = X"primary" ]; then
    mycli --help
else
    exec "$@"
fi
