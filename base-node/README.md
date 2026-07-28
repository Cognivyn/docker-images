# `ghcr.io/cognivyn/base-node`

Standard Node.js (v20 LTS) container image built on top of `ghcr.io/cognivyn/base-runtime`.

## Features
- Node.js LTS (v20.x)
- Pre-configured `npm`, `pnpm`, and `yarn` via Corepack
- Non-root execution (`cognivyn` user)

## Usage in Node.js Services

```dockerfile
FROM ghcr.io/cognivyn/base-node:latest

WORKDIR /app
COPY --chown=cognivyn:cognivyn package*.json ./
RUN npm ci --only=production

COPY --chown=cognivyn:cognivyn . .

EXPOSE 3000
CMD ["npm", "start"]
```
