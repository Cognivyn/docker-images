ARG BASE_IMAGE=ghcr.io/cognivyn/base-runtime:latest
FROM ${BASE_IMAGE}

LABEL maintainer="Cognivyn DevOps <devops@cognivyn.com>"
LABEL org.opencontainers.image.source="https://github.com/Cognivyn/docker-images"
LABEL org.opencontainers.image.description="Cognivyn Python Base Image"

USER root

# Install Python 3.11 & build tools
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

CMD ["python3", "--version"]
