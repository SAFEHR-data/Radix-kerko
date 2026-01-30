#!/bin/sh
set -eu

# Ensure instance dir exists
mkdir -p /kerkoapp/instance

# If Render secret file exists, copy it into the place Kerko expects
if [ -f /etc/secrets/.secrets.toml ]; then
  cp /etc/secrets/.secrets.toml /kerkoapp/instance/.secrets.toml
  chmod 600 /kerkoapp/instance/.secrets.toml || true
fi

: "${PORT:=80}"

flask kerko sync || true

exec gunicorn \
  --bind 0.0.0.0:"$PORT" \
  --threads 4 \
  --log-level info \
  --error-logfile - \
  --access-logfile - \
  wsgi:app
