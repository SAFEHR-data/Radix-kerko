FROM whiskyechobravo/kerkoapp:latest

# Move config over
COPY instance/config.toml /kerkoapp/instance/config.toml

# Optional: add a tiny entrypoint for periodic sync.
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Render/Fly often require binding to PORT; KerkoApp image binds to 80 by default.
# We'll keep the container listening on 80 and let the platform route to it.
CMD ["/entrypoint.sh"]
