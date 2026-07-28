FROM ubuntu:22.04

LABEL maintainer="Cognivyn DevOps <devops@cognivyn.com>"
LABEL org.opencontainers.image.source="https://github.com/Cognivyn/docker-images"
LABEL org.opencontainers.image.description="Cognivyn Base Runtime Container Image"

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Install core runtime dependencies & security updates
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    wget \
    git \
    jq \
    gnupg \
    unzip \
    tar \
    bzip2 \
    procps \
    net-tools \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create non-root system user & group
RUN groupadd -g 10001 cognivyn && \
    useradd -u 10001 -g cognivyn -m -s /bin/bash cognivyn && \
    echo "cognivyn ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/cognivyn && \
    chmod 0440 /etc/sudoers.d/cognivyn

WORKDIR /app

USER cognivyn

CMD ["/bin/bash"]
