# Awesome Caderno SQL Core

A text RPG for psql where players create a character with an INSERT and a trigger narrates the intro. The game rules are written in plpgsql and the schema is versioned with Flyway migrations.

## Overview

The game is a PostgreSQL schema that players use from psql. Their SQL statements advance the story, and the database answers with notices.

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

Players who want a ready character can copy one from the templates. The use_template function takes a template id and inserts that character into character_info.

```sql
SELECT * FROM char_templates;
SELECT use_template(1);
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
