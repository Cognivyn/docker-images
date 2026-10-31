ARG BASE_IMAGE=ghcr.io/cognivyn/base-runtime:latest
FROM ${BASE_IMAGE}

LABEL maintainer="Cognivyn DevOps <devops@cognivyn.com>"
LABEL org.opencontainers.image.source="https://github.com/Cognivyn/docker-images"
LABEL org.opencontainers.image.description="Cognivyn Python Base Image"

# Pin specific Python version capability (Ubuntu 22.04 ships 3.10; apt pinning required for 3.11)
ARG PYTHON_VERSION=3.11
LABEL org.opencontainers.image.version="${PYTHON_VERSION}"

USER root

# Install Python ${PYTHON_VERSION} & build tools
RUN python3 -c "import sys; assert sys.version_info[:2] == (${PYTHON_VERSION//./,}), f'Expected Python ${PYTHON_VERSION}, got {sys.version}'" || (echo "Python version mismatch: expected ${PYTHON_VERSION}" && exit 1)

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --no-cache-dir --upgrade pip setuptools wheel poetry

USER cognivyn
WORKDIR /app

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHON_VERSION=${PYTHON_VERSION}

CMD ["python3", "--version"]

