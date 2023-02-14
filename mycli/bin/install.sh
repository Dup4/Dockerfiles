#! /bin/bash

if [[ "${VERSION}" == "latest" ]]; then
    pip install mycli
else
    pip install -force-reinstall -v "mycli==${VERSION}"
fi

apt update
apt install --no-install-recommends --no-install-suggests -y less
apt clean
