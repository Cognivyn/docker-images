ARG BASE_IMAGE=ghcr.io/cognivyn/base-runtime:latest
FROM ${BASE_IMAGE}

LABEL maintainer="Cognivyn DevOps <devops@cognivyn.com>"
LABEL org.opencontainers.image.source="https://github.com/Cognivyn/docker-images"
LABEL org.opencontainers.image.description="Cognivyn PHP Base Image"

# Pin specific PHP version capability
ARG PHP_VERSION=8.3
LABEL org.opencontainers.image.version="${PHP_VERSION}"

USER root

# Install PHP and common extensions
RUN apt-get update && apt-get install -y --no-install-recommends \
    php-cli \
    php-common \
    php-mbstring \
    php-xml \
    php-curl \
    php-zip \
    php-mysql \
    php-pgsql \
    php-gd \
    php-bcmath \
    php-intl \
    && rm -rf /var/lib/apt/lists/*

RUN php -v | grep -q "PHP ${PHP_VERSION}" || (echo "PHP version mismatch: expected ${PHP_VERSION}" && exit 1)

USER cognivyn
WORKDIR /app

ENV PHP_VERSION=${PHP_VERSION}

CMD ["php", "--version"]
