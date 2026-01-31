#!/bin/sh
set -e

mkdir -p /kerkoapp/instance

# Always refresh secrets from Render secret file if present
if [ -f /etc/secrets/.secrets.toml ]; then
  cp -f /etc/secrets/.secrets.toml /kerkoapp/instance/.secrets.toml
  chmod 600 /kerkoapp/instance/.secrets.toml || true
fi

# Always refresh config from baked-in config if present
if [ -f /kerkoapp/config.toml ]; then
  cp -f /kerkoapp/config.toml /kerkoapp/instance/config.toml
fi

: "${PORT:=10000}"

exec gunicorn \
  --bind 0.0.0.0:"$PORT" \
  --threads 4 \
  --log-level info \
  --error-logfile - \
  --access-logfile - \
  wsgi:app
