#!/usr/bin/with-contenv bashio

# Port & RAG-Service aus der Konfiguration laden
PAPERLESS_AI_PORT="$(bashio::config 'paperless_ai_port')"
RAG_SERVICE_URL="$(bashio::config 'rag_service_url')"

export PAPERLESS_AI_PORT=${PAPERLESS_AI_PORT:-3000}
export RAG_SERVICE_URL=${RAG_SERVICE_URL:-http://localhost:8000}
export RAG_SERVICE_ENABLED=true

# Zielordner auf dem Host (sichtbar unter /share/paperless_ai_data)
SHARE_DIR="/share/paperless_ai_data"
mkdir -p "$SHARE_DIR"

# Bestehenden Pfad im Container entfernen, falls nötig
if [ ! -L /app/data ]; then
  echo "📦 /app/data wird nach $SHARE_DIR verlinkt"
  rm -rf /app/data
  ln -s "$SHARE_DIR" /app/data
fi

# Nur zur Kontrolle (Debug-Ausgabe ins Log)
echo "📂 Inhalt von /app/data:"
ls -la /app/data || echo "⚠️  /app/data nicht lesbar"

# Start der Anwendung
exec ./start-services.sh
