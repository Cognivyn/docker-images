ARG BASE_IMAGE=ghcr.io/cognivyn/base-runtime:latest
FROM ${BASE_IMAGE}

LABEL maintainer="Cognivyn DevOps <devops@cognivyn.com>"
LABEL org.opencontainers.image.source="https://github.com/Cognivyn/docker-images"
LABEL org.opencontainers.image.description="Cognivyn Node.js Base Image"

USER root

ENV NODE_VERSION=20.x

# Install Node.js LTS (v20) & global package managers
RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION} | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm@latest corepack && \
    corepack enable && \
    rm -rf /var/lib/apt/lists/*

USER cognivyn
WORKDIR /app

CMD ["node", "-v"]
