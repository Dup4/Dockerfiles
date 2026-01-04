#!/bin/bash
set -euo pipefail

# ===========================================
# OpenResty Compilation Install Script
# ===========================================

TOP_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
cd "${TOP_DIR}"

# Default versions (can be overridden via environment variables)
OPENRESTY_VERSION="${OPENRESTY_VERSION:-1.27.1.2}"
NGINX_RTMP_MODULE_VERSION="${NGINX_RTMP_MODULE_VERSION:-v1.2.2}"
NGINX_VOD_MODULE_VERSION="${NGINX_VOD_MODULE_VERSION:-1.33}"
NGINX_VTS_VERSION="${NGINX_VTS_VERSION:-v0.2.5}"
NGX_GEOIP2_VERSION="${NGX_GEOIP2_VERSION:-3.4}"

MODULES_DIR="${TOP_DIR}/modules"
mkdir -p "${MODULES_DIR}"
cd "${MODULES_DIR}"

echo "=== Downloading third-party modules ==="

# 1. nginx-rtmp-module - RTMP streaming support
echo "Downloading nginx-rtmp-module v${NGINX_RTMP_MODULE_VERSION}..."
git clone --depth 1 --branch "${NGINX_RTMP_MODULE_VERSION}" \
    https://github.com/arut/nginx-rtmp-module.git

# 2. nginx-vod-module - VOD support (HLS/DASH)
echo "Downloading nginx-vod-module ${NGINX_VOD_MODULE_VERSION}..."
git clone --depth 1 --branch "${NGINX_VOD_MODULE_VERSION}" \
    https://github.com/kaltura/nginx-vod-module.git

# 3. nginx-module-vts - Virtual host traffic status
echo "Downloading nginx-module-vts v${NGINX_VTS_VERSION}..."
git clone --depth 1 --branch "${NGINX_VTS_VERSION}" \
    https://github.com/vozlt/nginx-module-vts.git

# 4. ngx_brotli - Brotli compression
echo "Downloading ngx_brotli..."
git clone --depth 1 https://github.com/google/ngx_brotli.git
cd ngx_brotli
git submodule update --init --recursive
cd "${MODULES_DIR}"

# 5. ngx_http_geoip2_module - GeoIP2 database support
echo "Downloading ngx_http_geoip2_module ${NGX_GEOIP2_VERSION}..."
git clone --depth 1 --branch "${NGX_GEOIP2_VERSION}" \
    https://github.com/leev/ngx_http_geoip2_module.git

echo "=== Downloading OpenResty source ==="
cd "${TOP_DIR}"
wget -q "https://openresty.org/download/openresty-${OPENRESTY_VERSION}.tar.gz"
tar -xzf "openresty-${OPENRESTY_VERSION}.tar.gz"
cd "openresty-${OPENRESTY_VERSION}"

echo "=== Configuring OpenResty ==="
./configure \
    --prefix=/usr/local/openresty \
    --with-pcre-jit \
    --with-http_ssl_module \
    --with-http_v2_module \
    --with-http_realip_module \
    --with-http_gzip_static_module \
    --with-http_gunzip_module \
    --with-http_stub_status_module \
    --with-http_sub_module \
    --with-http_flv_module \
    --with-http_mp4_module \
    --with-http_secure_link_module \
    --with-http_slice_module \
    --with-stream \
    --with-stream_ssl_module \
    --with-stream_ssl_preread_module \
    --with-stream_realip_module \
    --with-http_image_filter_module \
    --add-module="${MODULES_DIR}/nginx-rtmp-module" \
    --add-module="${MODULES_DIR}/nginx-vod-module" \
    --add-module="${MODULES_DIR}/nginx-module-vts" \
    --add-module="${MODULES_DIR}/ngx_brotli" \
    --add-module="${MODULES_DIR}/ngx_http_geoip2_module" \
    -j"$(nproc)"

echo "=== Building OpenResty ==="
make -j"$(nproc)"

echo "=== Installing OpenResty ==="
make install

echo "=== Cleaning up ==="
cd "${TOP_DIR}"
rm -rf "${MODULES_DIR}" "openresty-${OPENRESTY_VERSION}" "openresty-${OPENRESTY_VERSION}.tar.gz"

echo "=== OpenResty installation completed ==="
/usr/local/openresty/nginx/sbin/nginx -V
