# `ghcr.io/cognivyn/base-runtime`

Minimal, hardened Ubuntu 22.04 base container image used as the foundational layer for all Cognivyn microservices and application images.

## Features
- Base OS: Ubuntu 22.04 LTS (patched)
- Pre-installed tools: `curl`, `wget`, `git`, `jq`, `ca-certificates`, `gnupg`, `sudo`
- Non-root user: `cognivyn` (UID/GID: `10001`)
- Working directory: `/app`

## Usage in App Dockerfiles

```dockerfile
FROM ghcr.io/cognivyn/base-runtime:latest

# Switch to root for package installation if needed
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    your-app-packages \
    && rm -rf /var/lib/apt/lists/*

# Switch back to non-root user
USER cognivyn
WORKDIR /app
COPY --chown=cognivyn:cognivyn . .

CMD ["./start.sh"]
```
