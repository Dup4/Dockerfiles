#! /bin/bash

if [[ "${VERSION}" == "latest" ]]; then
    pip install ansible
else
    pip install -force-reinstall -v "ansible==${VERSION}"
fi
