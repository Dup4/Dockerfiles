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

cd code || exit 1

cargo build --all --release

mv /root/code/target/release /root/release
rm -rf /root/code/target

cp /root/code/default.toml /root/release
