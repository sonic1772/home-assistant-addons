#!/usr/bin/with-contenv bashio

# Konfigurationswerte auslesen
PAPERLESS_AI_PORT="$(bashio::config 'paperless_ai_port')"
RAG_SERVICE_URL="$(bashio::config 'rag_service_url')"

export PAPERLESS_AI_PORT=${PAPERLESS_AI_PORT:-3000}
export RAG_SERVICE_URL=${RAG_SERVICE_URL:-http://localhost:8000}
export RAG_SERVICE_ENABLED=true

# Persistentes Verzeichnis unter /share
SHARE_DIR="/share/paperless_ai_data"
mkdir -p "$SHARE_DIR"

# Symlink nach /app/data setzen
if [ ! -L /app/data ]; then
  rm -rf /app/data
  ln -s "$SHARE_DIR" /app/data
fi

# Start der Anwendung
exec ./start-services.sh
