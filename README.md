# Awesome Caderno SQL Core

A text RPG played entirely inside PostgreSQL. You log in with psql, create a hero with an INSERT, and the database narrates your story back to you.

No app server, no game engine. Triggers are the game master, database roles are the players, and versioned SQL migrations are the world.

## How it works

- A login event trigger greets you when you connect and points you to the character creation table.
- Inserting a row into character_info creates your character. A BEFORE trigger validates it, creates a database role for the player and narrates the intro with RAISE NOTICE.
- An AFTER trigger sets up the initial character state once the row exists.
- Races and classes live in their own tables with masculine and feminine forms, so the narration reads correctly in Portuguese (um mago, uma maga).
- Gender is a Postgres enum with two values, masculino and feminino.
- Characters cannot be edited after creation. Delete and recreate instead, which also drops the player role.
- A help table holds tips you can read at any time with SELECT * FROM help.

## Requirements

- Docker
- psql
- make

## Quick start

```bash
make setup   # starts Postgres 17 and runs the Flyway migrations
make run     # opens psql as the rpg user
```

Then create your character.

```sql
SELECT * FROM races;
SELECT * FROM classes;

INSERT INTO character_info (name, description, class, race, gender)
VALUES ('Aria', 'Uma maga curiosa', 2, 1, 'feminino');
```

## Commands

- make up starts the Postgres container on localhost port 5433.
- make migrate applies pending migrations with Flyway in debug mode.
- make down removes the container and keeps the data.
- make wipe removes the container and the data volume for a full reset.

## Project layout

- migrations holds the versioned SQL. V0 is the login hook, V1 races, V2 classes, V3 characters and V4 the help table.
- scripts holds the shell helpers behind the make targets.
- flyway.conf points Flyway at the local database.

## Why

This started as a way to learn PostgreSQL by pushing it too far. It covers triggers, event triggers, roles and permissions, enums, composite types and set returning functions, all inside a game.
