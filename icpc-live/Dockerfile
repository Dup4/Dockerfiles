# ============================================
# Stage 1: Builder - Compile application
# ============================================
FROM eclipse-temurin:21-jdk-noble AS builder

ARG REPO=https://github.com/icpc/live-v3.git
ARG REF=main
ARG BUILD_VERSION=latest
ARG NODE_VERSION=22
ARG PNPM_VERSION=10.18.3

USER root
WORKDIR /build

ENV DEBIAN_FRONTEND=noninteractive

# Install Node.js and pnpm for frontend build
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    ca-certificates \
    unzip \
    && curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g pnpm@${PNPM_VERSION} \
    && rm -rf /var/lib/apt/lists/*

# Clone repository at specified ref
RUN git clone --depth 1 --branch ${REF} ${REPO} . 2>/dev/null || \
    (git clone ${REPO} . && git checkout ${REF})

# Build with cache mounts for faster rebuilds
RUN --mount=type=cache,target=/root/.gradle \
    --mount=type=cache,target=/root/.pnpm-store \
    pnpm config set store-dir /root/.pnpm-store && \
    ./gradlew release -Pnpm.download=false -Pbuild_version=${BUILD_VERSION} --no-daemon

# Extract release zip to /app
RUN mkdir -p /app && \
    unzip -q artifacts/live-v3-*.zip -d /app

# ============================================
# Stage 2: Runtime - Minimal production image
# ============================================
FROM eclipse-temurin:21-jre-noble

WORKDIR /app

ENV DEBIAN_FRONTEND=noninteractive

# Install runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    tzdata && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /config

# Copy application from builder
COPY --from=builder /app /app

# Environment configuration
ENV CONFIG_DIR="/config"
ENV APP_PORT="8080"
ENV TZ="UTC"

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -sf http://localhost:${APP_PORT}/ || exit 1

EXPOSE 8080
VOLUME ["/config"]
CMD ["/bin/bash"]
