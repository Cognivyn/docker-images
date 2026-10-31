ARG BASE_IMAGE=ghcr.io/cognivyn/base-bun:latest
FROM ${BASE_IMAGE}

LABEL maintainer="Cognivyn DevOps <devops@cognivyn.com>"
LABEL org.opencontainers.image.source="https://github.com/Cognivyn/docker-images"
LABEL org.opencontainers.image.description="Cognivyn Bun + Infisical CLI Base Image"

USER root

# Install Infisical CLI via Cloudsmith deb repository
RUN curl -1sLf 'https://dl.cloudsmith.io/public/infisical/infisical-cli/setup.deb.sh' | bash && \
    apt-get install -y infisical && \
    rm -rf /var/lib/apt/lists/*

USER cognivyn
WORKDIR /app

CMD ["infisical", "--version"]