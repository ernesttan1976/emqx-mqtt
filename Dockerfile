FROM emqx/emqx:latest

# Expose necessary ports
EXPOSE 1883 8883 8083 8084 18083 4370

# Set health check
HEALTHCHECK --interval=5s --timeout=3s --retries=3 CMD curl -fs http://localhost:18083/ || exit 1