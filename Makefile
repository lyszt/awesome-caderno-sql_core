.PHONY: setup up down wipe migrate run

setup: up migrate
	@:

up:
	./scripts/db-up.sh

down:
	./scripts/db-down.sh

wipe:
	./scripts/db-down.sh --wipe

migrate:
	./scripts/migrate.sh migrate

run:
	PGPASSWORD=rpg psql -h localhost -p 5433 -U rpg -d rpg 
