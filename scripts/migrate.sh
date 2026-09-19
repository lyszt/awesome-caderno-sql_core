#!/usr/bin/env bash
# Runs Flyway against the local Postgres container, applying any
# unapplied .sql files from migrations/ in version order.
set -euo pipefail

cd "$(dirname "$0")/.."

docker run --rm \
  --network rpg_net \
  -v "$(pwd)/migrations:/flyway/sql:z" \
  -v "$(pwd)/flyway.conf:/flyway/conf/flyway.conf:z" \
  flyway/flyway:10 -X "${@:-migrate}"
