# `ghcr.io/cognivyn/base-php`

Standard PHP (8.3) container image built on top of `ghcr.io/cognivyn/base-runtime`.

## Features
- PHP 8.3 pinned via `PHP_VERSION` build arg
- Common extensions: mbstring, xml, curl, zip, mysql, pgsql, gd, bcmath, intl
- Pre-configured non-root `cognivyn` user
- Non-interactive installation

## Usage in PHP Services

```dockerfile
FROM ghcr.io/cognivyn/base-php:8.3

WORKDIR /app

# Copy application source
COPY --chown=cognivyn:cognivyn . .

EXPOSE 9000
CMD ["php", "-S", "0.0.0.0:9000", "-t", "public"]
```

## Pinning a Specific PHP Version

The image supports pinning a specific PHP version at build time:

```bash
docker build \
  --build-arg PHP_VERSION=8.2 \
  -t ghcr.io/cognivyn/base-php:8.2 \
  ./base-php
```

The default version is `8.3`. The build fails if the installed PHP version does not match the requested `PHP_VERSION`, ensuring version consistency.
