#!/usr/bin/env bash
# Stops and removes the Postgres container.
# Pass --wipe to also delete the data volume (full reset).
set -euo pipefail

docker rm -f rpg_postgres >/dev/null 2>&1 || true

if [[ "${1:-}" == "--wipe" ]]; then
  docker volume rm rpg_pgdata >/dev/null 2>&1 || true
  echo "Container removed and data volume wiped."
else
  echo "Container removed. Data volume kept (rpg_pgdata)."
fi
