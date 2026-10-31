# Cognivyn Docker Infrastructure & Base Images

[![GitHub Container Registry](https://img.shields.io/badge/GHCR-ghcr.io%2Fcognivyn-blue?logo=github)](https://github.com/orgs/Cognivyn/packages)
[![Build Base Images](https://github.com/Cognivyn/docker-images/actions/workflows/build-base-images.yml/badge.svg)](https://github.com/Cognivyn/docker-images/actions/workflows/build-base-images.yml)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)

Central repository for Cognivyn's Docker base images, automated GitHub Actions container workflows, and deployment standards.

---

## 📦 Container Registry

All container images are published to **GitHub Container Registry (GHCR)** under the `ghcr.io/cognivyn` organization namespace:

```
ghcr.io/cognivyn/<image-name>:<tag>
```

### Published Base Images

| Image | Path | Description | Access |
| :--- | :--- | :--- | :--- |
| **`ghcr.io/cognivyn/base-runtime`** | [`base-runtime/`](./base-runtime) | Hardened Ubuntu 22.04 base with common security patches and utilities. | Private |
| **`ghcr.io/cognivyn/base-node`** | [`base-node/`](./base-node) | Node.js (v20 LTS) runtime environment extending `base-runtime`. | Private |
| **`ghcr.io/cognivyn/base-python`** | [`base-python/`](./base-python) | Python (v3.11) runtime environment extending `base-runtime`. | Private |
| **`ghcr.io/cognivyn/base-bun`** | [`base-bun/`](./base-bun) | Bun runtime environment extending `base-runtime`. | Private |
| **`ghcr.io/cognivyn/base-php`** | [`base-php/`](./base-php) | PHP (v8.3) runtime environment extending `base-runtime`. | Private |

---

## 🏷️ Image Tagging Standards

All built images follow strict tagging rules:

- `:latest` — Latest commit on `main` branch.
- `:vX.Y.Z` — Tagged releases matching GitHub release version.
- `:sha-<commit>` — Specific commit SHA for immutable production deployments.

---

## 🚀 Local Development Quickstart

### Prerequisites
- Docker Engine / Docker Desktop
- Personal Access Token (Classic) with `write:packages` and `read:packages` scopes.

### 1. Authenticate to GHCR
```bash
echo "$GITHUB_PAT" | docker login ghcr.io -u <your-github-username> --password-stdin
```

### 2. Local Build Helper
Use the helper scripts provided in `scripts/`:

```bash
# Build all base images locally
./scripts/build-local.sh base-runtime
./scripts/build-local.sh base-node

# Publish base images manually (if needed)
./scripts/publish-local.sh base-runtime latest
```

---

## ⚙️ CI/CD Workflows

This repository contains automated GitHub Actions workflows:

1. **`build-base-images.yml`**: Automatically builds and pushes `base-runtime`, `base-node`, `base-python`, `base-bun`, `base-php`, and `base-bun-infisical` when changes are merged into `main`.
2. **`vulnerability-scan.yml`**: Weekly security vulnerability scanning using Trivy.
3. **`prune-ghcr-packages.yml`**: Scheduled maintenance job to clean up untagged images.

---

## 📄 License
Internal software infrastructure © Cognivyn. Licensed under the MIT License.
