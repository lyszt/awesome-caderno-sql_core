# Awesome Caderno SQL Core

A text RPG for psql where players create a character with an INSERT and a trigger narrates the intro. The game rules are written in plpgsql and the schema is versioned with Flyway migrations.

## Overview

Players interact with the game through SQL statements in psql. Each statement changes a table, and triggers on that table apply the game rules and reply with notices. Functions hold the shared logic, and the tables hold the world data and the player state.

## Requirements

- Docker
- psql
- make

## Quick start

```bash
make setup   # starts Postgres 17 and runs the Flyway migrations
make run     # opens psql as the rpg user
```

Players then read the available races and classes and insert a character.

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
- make wipe removes the container and the data volume.

## Project layout

- migrations holds the versioned SQL, and each file contains the tables, types and functions for one part of the game. The file name says which part, like V1__races.sql.
- scripts holds the shell helpers behind the make targets.
- flyway.conf holds the Flyway connection settings for the local database.

## Purpose

The project is a way to practice PostgreSQL. It uses triggers, event triggers, roles and permissions, enums, composite types and set returning functions.
