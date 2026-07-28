#!/usr/bin/env bash
set -e

REGISTRY="ghcr.io/cognivyn"
TARGET="${1:-all}"
TAG="${2:-latest}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

publish_image() {
    local IMAGE_NAME="$1"
    echo "🚀 Publishing ${REGISTRY}/${IMAGE_NAME}:${TAG} to GHCR..."
    docker push "${REGISTRY}/${IMAGE_NAME}:${TAG}"
    echo "✅ Successfully published ${REGISTRY}/${IMAGE_NAME}:${TAG}"
}

if [ "$TARGET" = "all" ]; then
    publish_image "base-runtime"
    publish_image "base-node"
    publish_image "base-python"
    publish_image "base-bun"
else
    publish_image "$TARGET"
fi
