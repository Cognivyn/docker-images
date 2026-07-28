# `ghcr.io/cognivyn/base-python`

Standard Python (3.11) container image built on top of `ghcr.io/cognivyn/base-runtime`.

## Features
- Python 3.11 + `pip`, `setuptools`, `wheel`, `poetry`
- Pre-configured non-root `cognivyn` user
- Unbuffered output (`PYTHONUNBUFFERED=1`)

## Usage in Python Services

```dockerfile
FROM ghcr.io/cognivyn/base-python:latest

WORKDIR /app
COPY --chown=cognivyn:cognivyn requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY --chown=cognivyn:cognivyn . .

EXPOSE 8000
CMD ["python3", "main.py"]
```
