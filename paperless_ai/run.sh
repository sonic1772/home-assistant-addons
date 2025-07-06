#!/usr/bin/with-contenv bashio

# Port und Optionen lesen
PAPERLESS_AI_PORT="$(bashio::config 'paperless_ai_port')"
export PAPERLESS_AI_PORT=${PAPERLESS_AI_PORT:-3000}

# Zielordner im gemounteten Share-Verzeichnis
SHARE_DATA_DIR="/share/paperless_ai_data"

# Ordner anlegen
mkdir -p "$SHARE_DATA_DIR"

# Wenn kein Symlink existiert, lege einen an
if [ ! -L /app/data ]; then
  rm -rf /app/data
  ln -s "$SHARE_DATA_DIR" /app/data
fi

# Start der Anwendung
exec ./start-services.sh

