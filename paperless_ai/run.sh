#!/usr/bin/with-contenv bashio

# Port aus config.yaml holen oder Fallback verwenden
PAPERLESS_AI_PORT=$(bashio::config 'paperless_ai_port')
export PAPERLESS_AI_PORT=${PAPERLESS_AI_PORT:-3000}

# optional: RAG URL setzen
if bashio::config.has_value 'rag_service_url'; then
  export RAG_SERVICE_URL=$(bashio::config 'rag_service_url')
fi

# Persistentes Verzeichnis vorbereiten
mkdir -p /data/app_data

# Symlink erstellen, damit der Container wie in Docker Compose funktioniert
if [ ! -L /app/data ]; then
  rm -rf /app/data
  ln -s /data/app_data /app/data
fi

# Start der App (wie im Dockerfile von clusterzx/paperless-ai definiert)
exec ./start-services.sh
