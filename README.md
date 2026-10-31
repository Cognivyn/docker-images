# Cognivyn Docker Images

[![GHCR](https://img.shields.io/badge/ghcr.io-cognivyn-2496ED?logo=github&logoColor=white)](https://github.com/orgs/Cognivyn/packages?repo_name=docker-images)
[![Build Status](https://github.com/Cognivyn/docker-images/actions/workflows/build-base-images.yml/badge.svg)](https://github.com/Cognivyn/docker-images/actions/workflows/build-base-images.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Security Scan](https://github.com/Cognivyn/docker-images/actions/workflows/vulnerability-scan.yml/badge.svg)](https://github.com/Cognivyn/docker-images/actions/workflows/vulnerability-scan.yml)

Hardened, production-ready Docker base images for Cognivyn services. All images are built on a secure Ubuntu 22.04 foundation with automated CI/CD, consistent tagging, and non-root execution by default.

## Available Images

| Image | Base | Description | Status |
|---|---|---|---|
| [`ghcr.io/cognivyn/base-runtime`](./base-runtime) | Ubuntu 22.04 | Hardened base image with security patches and essential utilities | Private |
| [`ghcr.io/cognivyn/base-node`](./base-node) | `base-runtime` | Node.js 20 LTS with npm, pnpm, and yarn via Corepack | Private |
| [`ghcr.io/cognivyn/base-python`](./base-python) | `base-runtime` | Python 3.11 runtime environment | Private |
| [`ghcr.io/cognivyn/base-bun`](./base-bun) | `base-runtime` | [Bun](https://bun.sh) runtime environment | Private |
| [`ghcr.io/cognivyn/base-bun-infisical`](./base-bun-infisical) | `base-bun` | Bun runtime with [Infisical CLI](https://infisical.com/docs/cli/overview) pre-installed | Private |
| [`ghcr.io/cognivyn/base-php`](./base-php) | `base-runtime` | PHP 8.3 runtime environment | Private |

## Image Tagging

Images follow a consistent tagging strategy for reliability and traceability:

| Tag | Use Case |
|---|---|
| `:latest` | Latest build from the `main` branch |
| `:vX.Y.Z` | Official releases tied to GitHub releases |
| `:sha-<commit>` | Immutable, commit-specific builds for reproducible deployments |

## Getting Started

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/) or [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- A GitHub Personal Access Token (Classic) with `read:packages` and `write:packages` scopes

### Authentication

```bash
echo "$GITHUB_PAT" | docker login ghcr.io -u <your-github-username> --password-stdin
```

### Usage

```dockerfile
FROM ghcr.io/cognivyn/base-node:latest

WORKDIR /app
COPY --chown=cognivyn:cognivyn package*.json ./
RUN npm ci --omit=dev

COPY --chown=cognivyn:cognivyn . .

USER cognivyn
EXPOSE 3000
CMD ["npm", "start"]
```

### Local Development

Use the provided helper scripts for building and publishing images locally:

```bash
# Build a specific base image
./scripts/build-local.sh base-node

# Build all base images
./scripts/build-local.sh

# Publish an image to GHCR
./scripts/publish-local.sh base-node latest
```

## CI/CD

| Workflow | Trigger | Purpose |
|---|---|---|
| [`build-base-images.yml`](.github/workflows/build-base-images.yml) | Push to `main` or manual dispatch | Builds and publishes all base images to GHCR |
| [`vulnerability-scan.yml`](.github/workflows/vulnerability-scan.yml) | Weekly schedule | Scans images for CVEs using [Trivy](https://github.com/aquasecurity/trivy) |
| [`prune-ghcr-packages.yml`](.github/workflows/prune-ghcr-packages.yml) | Scheduled | Cleans up untagged images from GHCR |

## Security

- All images run as a non-root user (`cognivyn`) by default
- Built on Ubuntu 22.04 with regular security updates
- Automated vulnerability scanning with Trivy
- Minimal attack surface with only essential dependencies

## Contributing

1. Create a feature branch from `main`
2. Make your changes to the relevant base image
3. Test locally with `build-local.sh`
4. Open a pull request with a clear description of changes

## License

© Cognivyn. Licensed under the [MIT License](LICENSE).