#! /bin/bash

cd /root || exit 1

if [[ "${VERSION}" == "latest" ]]; then
    git clone https://github.com/clia/rcproxy.git \
        code
else
    git clone https://github.com/clia/rcproxy.git \
        -b "${VERSION}" \
        code
fi
