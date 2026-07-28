# `ghcr.io/cognivyn/base-bun`

Standard Bun container image built on top of `ghcr.io/cognivyn/base-runtime`.

## Features
- Latest Bun runtime environment (`bun` & `bunx` installed system-wide in `/usr/local/bin`)
- Ultra-fast JavaScript & TypeScript execution, package manager, and bundler
- Non-root execution (`cognivyn` user)

## Usage in Bun Services

```dockerfile
FROM ghcr.io/cognivyn/base-bun:latest

WORKDIR /app

# Install dependencies using Bun
COPY --chown=cognivyn:cognivyn bun.lockb package.json ./
RUN bun install --production

# Copy application source
COPY --chown=cognivyn:cognivyn . .

EXPOSE 3000
CMD ["bun", "run", "index.ts"]
```
