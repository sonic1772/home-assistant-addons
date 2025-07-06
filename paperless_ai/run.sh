#!/usr/bin/with-contenv bashio

PAPERLESS_AI_PORT="$(bashio::config 'paperless_ai_port')"
export PAPERLESS_AI_PORT=${PAPERLESS_AI_PORT:-3000}

SHARE_DATA_DIR="/share/paperless_ai_data"

# Sicherstellen, dass /share existiert
if [ ! -d /share ]; then
  echo "ERROR: /share is not mounted. Did you forget map: - share:rw in config.yaml?"
  exit 1
fi

# Sicherstellen, dass persistentes Verzeichnis da ist
mkdir -p "$SHARE_DATA_DIR"

# Nur setzen, wenn der Symlink nicht existiert
if [ ! -L /app/data ]; then
  echo "Setting up symlink from /app/data to $SHARE_DATA_DIR"
  rm -rf /app/data
  ln -s "$SHARE_DATA_DIR" /app/data
fi

# Start der App
exec ./start-services.sh
