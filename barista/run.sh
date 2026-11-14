#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
set -e

# Options written by the Supervisor for this add-on
OPTIONS=/data/options.json

ADDRESS="$(jq -r '.address // ""' "${OPTIONS}")"
PORT=8080  # fixed: must match ingress_port in config.yaml
bashio::log.level "$(jq -r '.log_level // "info"' "${OPTIONS}")"

if [ -z "${ADDRESS}" ]; then
    bashio::log.warning "No 'address' configured. Scanning for De'Longhi machines..."
    barista scan || true
    bashio::log.fatal "Set the 'address' option to your machine's BLE address and restart the add-on."
    exit 1
fi

bashio::log.info "Starting Barista for ${ADDRESS} on port ${PORT}..."
exec barista start --address "${ADDRESS}" --port "${PORT}"
