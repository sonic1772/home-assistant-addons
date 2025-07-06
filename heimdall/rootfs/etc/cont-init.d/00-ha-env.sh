#!/usr/bin/with-contenv bashio

for k in $(bashio::jq "${__BASHIO_ADDON_CONFIG}" 'keys | .[]'); do
    # shellcheck disable=SC2086
    printf "%s" "$(bashio::config $k || true)" > /var/run/s6/container_environment/$k
done