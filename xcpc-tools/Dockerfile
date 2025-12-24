# Build stage
FROM node:24 AS builder

# Build arguments for repository and ref
ARG REPO=https://github.com/Dup4/xcpc-tools.git
ARG REF=main

WORKDIR /app

# Install build dependencies, clone repo at specified ref, build pkg binary
RUN apk add --no-cache git python3 make g++ && \
    git clone ${REPO} . && \
    git checkout ${REF} && \
    corepack enable && \
    yarn install --immutable && \
    yarn build:pkg

FROM alpine:latest

WORKDIR /app

RUN apk add --no-cache tini dumb-init

COPY --from=builder /app/dist/pkg/ /app/

EXPOSE 5283
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/app/xcpc-tools-linux"]
