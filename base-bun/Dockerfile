ARG BASE_IMAGE=ghcr.io/cognivyn/base-runtime:latest
FROM ${BASE_IMAGE}

LABEL maintainer="Cognivyn DevOps <devops@cognivyn.com>"
LABEL org.opencontainers.image.source="https://github.com/Cognivyn/docker-images"
LABEL org.opencontainers.image.description="Cognivyn Bun Base Image"

USER root

# Install unzip (required by bun installer) & Bun runtime
RUN apt-get update && apt-get install -y --no-install-recommends \
    unzip \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://bun.sh/install | bash && \
    mv /root/.bun/bin/bun /usr/local/bin/bun && \
    ln -s /usr/local/bin/bun /usr/local/bin/bunx && \
    rm -rf /root/.bun

USER cognivyn
WORKDIR /app

ENV BUN_INSTALL=/usr/local
ENV PATH=$BUN_INSTALL/bin:$PATH

CMD ["bun", "--version"]
