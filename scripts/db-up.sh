#!/usr/bin/env bash
set -euo pipefail

docker network create rpg_net >/dev/null 2>&1 || true

if docker ps --format '{{.Names}}' | grep -qx rpg_postgres; then
  echo "rpg_postgres is already running."
  exit 0
elif docker ps -a --format '{{.Names}}' | grep -qx rpg_postgres; then
  docker start rpg_postgres >/dev/null
else
  docker run -d \
    --name rpg_postgres \
    --network rpg_net \
    -p 5433:5432 \
    -e POSTGRES_USER=rpg \
    -e POSTGRES_PASSWORD=rpg \
    -e POSTGRES_DB=rpg \
    -v rpg_pgdata:/var/lib/postgresql/data \
    postgres:17
fi

echo "Waiting for Postgres to accept connections..."
until docker exec rpg_postgres pg_isready -U rpg >/dev/null 2>&1; do
  sleep 1
done
echo "Postgres is up on localhost:5433 (db=rpg, user=rpg, password=rpg)"
