#!/bin/sh
set -eu

mkdir -p /kerkoapp/instance

if [ -f /etc/secrets/.secrets.toml ]; then
  cp /etc/secrets/.secrets.toml /kerkoapp/instance/.secrets.toml
  chmod 600 /kerkoapp/instance/.secrets.toml || true
fi

# Render provides PORT; default locally
: "${PORT:=10000}"

# Start sync in background so Render sees an open port quickly
(
  flask kerko sync || true
) &

exec gunicorn \
  --bind 0.0.0.0:"$PORT" \
  --threads 4 \
  --log-level info \
  --error-logfile - \
  --access-logfile - \
  wsgi:app
