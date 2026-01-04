#!/bin/bash
set -e

NGINX_BIN="/usr/local/openresty/nginx/sbin/nginx"

case "${1}" in
    bash)
        exec bash
        ;;
    nginx|openresty)
        shift
        exec ${NGINX_BIN} "$@"
        ;;
    resty)
        shift
        exec /usr/local/openresty/bin/resty "$@"
        ;;
    luajit)
        shift
        exec /usr/local/openresty/luajit/bin/luajit "$@"
        ;;
    test)
        exec ${NGINX_BIN} -t
        ;;
    reload)
        exec ${NGINX_BIN} -s reload
        ;;
    version)
        exec ${NGINX_BIN} -V
        ;;
    *)
        exec ${NGINX_BIN} "$@"
        ;;
esac
