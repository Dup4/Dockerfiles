#! /bin/bash

if [[ "${VERSION}" == "latest" ]]; then
    pip install pgcli
else
    pip install -force-reinstall -v "pgcli==${VERSION}"
fi

apt update
apt install --no-install-recommends --no-install-suggests -y less
apt clean
