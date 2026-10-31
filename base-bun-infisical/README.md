# `ghcr.io/cognivyn/base-bun-infisical`

Bun runtime image with the Infisical CLI installed, built on top of `ghcr.io/cognivyn/base-bun`.

## Features
- Infisical CLI installed via Cloudsmith deb repository
- Bun runtime and `bunx` available system-wide (inherited from `base-bun`)
- Non-root execution (`cognivyn` user)

## Usage in Services

```dockerfile
FROM ghcr.io/cognivyn/base-bun-infisical:latest

WORKDIR /app

# Install dependencies using Bun
COPY --chown=cognivyn:cognivyn bun.lockb package.json ./
RUN bun install --production

# Copy application source
COPY --chown=cognivyn:cognivyn . .

EXPOSE 3000
CMD ["bun", "run", "index.ts"]
```