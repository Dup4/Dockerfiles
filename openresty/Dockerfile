# ============================================
# Stage 1: Builder - Compile OpenResty with modules
# ============================================
FROM ubuntu:24.04 AS builder

# Version arguments
ARG OPENRESTY_VERSION=1.27.1.2
ARG NGINX_RTMP_MODULE_VERSION=v1.2.2
ARG NGINX_VOD_MODULE_VERSION=1.33
ARG NGINX_VTS_VERSION=v0.2.5
ARG NGX_GEOIP2_VERSION=3.4

USER root
WORKDIR /build

ENV DEBIAN_FRONTEND=noninteractive

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    git \
    libgd-dev \
    libgeoip-dev \
    libmaxminddb-dev \
    libpcre2-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    libbrotli-dev \
    cmake \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Copy install script
COPY ./bin/install.sh /build/

# Set environment variables for install script
ENV OPENRESTY_VERSION=${OPENRESTY_VERSION} \
    NGINX_RTMP_MODULE_VERSION=${NGINX_RTMP_MODULE_VERSION} \
    NGINX_VOD_MODULE_VERSION=${NGINX_VOD_MODULE_VERSION} \
    NGINX_VTS_VERSION=${NGINX_VTS_VERSION} \
    NGX_GEOIP2_VERSION=${NGX_GEOIP2_VERSION}

# Execute compilation
RUN chmod +x /build/install.sh && bash /build/install.sh

# ============================================
# Stage 2: Runtime - Minimal runtime image
# ============================================
FROM ubuntu:24.04

USER root
WORKDIR /

ENV DEBIAN_FRONTEND=noninteractive

# Copy compiled OpenResty from builder stage
COPY --from=builder /usr/local/openresty /usr/local/openresty
# Copy entry script
COPY ./bin/docker_entry.sh /docker_entry.sh

# Install runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    tzdata \
    ca-certificates \
    libgd3 \
    libgeoip1t64 \
    libmaxminddb0 \
    libpcre2-8-0 \
    libssl3t64 \
    libxml2 \
    libxslt1.1 \
    zlib1g \
    libbrotli1 \
    curl \
    perl \
    && rm -rf /var/lib/apt/lists/* \
    && /usr/local/openresty/bin/opm get ledgetech/lua-resty-http

# Create necessary directories and user
RUN chmod +x /docker_entry.sh \
    && useradd -r -s /sbin/nologin nginx \
    && mkdir -p /var/log/nginx \
    && mkdir -p /var/cache/nginx \
    && mkdir -p /etc/nginx/conf.d \
    && chown -R nginx:nginx /var/log/nginx /var/cache/nginx

# Set PATH
ENV PATH=/usr/local/openresty/nginx/sbin:/usr/local/openresty/bin:/usr/local/openresty/luajit/bin:$PATH

# Expose ports (HTTP, HTTPS, RTMP, Status)
EXPOSE 80 443 1935 8080

ENTRYPOINT ["/docker_entry.sh"]
CMD ["nginx", "-g", "daemon off;"]
