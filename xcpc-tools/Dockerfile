# Build stage
FROM node:24 AS builder

# Build arguments for repository and ref
ARG REPO=https://github.com/Dup4/xcpc-tools.git
ARG REF=main

WORKDIR /app

# Install build dependencies, clone repo at specified ref, build pkg binary
RUN apt-get update && \
    apt-get install -y git python3 make g++ && \
    git clone ${REPO} . && \
    git checkout ${REF} && \
    corepack enable && \
    yarn install && \
    yarn build:pkg

# Runtime stage
FROM ubuntu:24.04

WORKDIR /app

# Copy the standalone binary from build stage
COPY --from=builder /app/dist/pkg/* /app/

EXPOSE 5283
CMD ["/app/xcpc-tools-linux"]
