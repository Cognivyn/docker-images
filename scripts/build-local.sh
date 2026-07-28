#!/usr/bin/env bash
set -e

REGISTRY="ghcr.io/cognivyn"
TAG="${2:-latest}"
TARGET="${1:-all}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

build_image() {
    local IMAGE_NAME="$1"
    local DOCKERFILE_PATH="${ROOT_DIR}/${IMAGE_NAME}/Dockerfile"

    if [ ! -f "$DOCKERFILE_PATH" ]; then
        echo "❌ Error: Dockerfile not found at ${DOCKERFILE_PATH}"
        exit 1
    fi

    echo "🐳 Building ${REGISTRY}/${IMAGE_NAME}:${TAG}..."
    docker build \
        --build-arg BASE_IMAGE="${REGISTRY}/base-runtime:${TAG}" \
        -t "${REGISTRY}/${IMAGE_NAME}:${TAG}" \
        -f "$DOCKERFILE_PATH" \
        "${ROOT_DIR}/${IMAGE_NAME}"
    echo "✅ Successfully built ${REGISTRY}/${IMAGE_NAME}:${TAG}"
}

if [ "$TARGET" = "all" ]; then
    build_image "base-runtime"
    build_image "base-node"
    build_image "base-python"
    build_image "base-bun"
else
    build_image "$TARGET"
fi
