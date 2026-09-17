

DROP TABLE IF EXISTS character_info;
CREATE TABLE character_info (
    id integer generated always as identity primary key,
    name varchar(20) unique,
    description text,
    class integer,
    gender varchar(15),
    race integer
);


DROP TYPE IF EXISTS player_states ;
CREATE TYPE player_states AS ENUM(
    'exploring','battle','dead'
);


DROP TABLE IF EXISTS character_states;
CREATE TABLE character_states(
    player_id integer references character_info(id) not null,
    state player_states not null,
    chapter_id integer not null
);


-- Character permissions

CREATE ROLE player NOLOGIN;
REVOKE UPDATE ON character_states FROM player;
REVOKE UPDATE ON character_info FROM player;

-- Functions


CREATE OR REPLACE FUNCTION check_character_created() RETURNS TRIGGER AS $$
DECLARE
    char_race races%ROWTYPE;
    char_class classes%ROWTYPE;
BEGIN  
    CASE TG_OP
        WHEN 'INSERT' THEN
            SELECT * INTO char_race FROM races WHERE races.id = NEW.race;
            SELECT * INTO char_class FROM classes WHERE classes.id = NEW.class;
            EXECUTE format('CREATE ROLE %I IN GROUP player', NEW.name);
            INSERT INTO character_states(player_id, state, chapter_id) VALUES (NEW.id, 'exploring',1);

            RAISE NOTICE 'Parabéns, você criou seu personagem.';
            PERFORM pg_sleep(2);
            RAISE NOTICE 'Seu personagem é %, um % da %a raça dos %s. Ainda não sabemos o que, mas algo te trouxe até
            esse MMORPG. Um motivo. ', NEW.name, char_class.name, char_race.descriptor, char_race.name;
            RETURN NEW;
        WHEN 'UPDATE' THEN
            RAISE NOTICE 'Personagens não podem ser alterados depois de criados.';
            RETURN OLD;
        WHEN 'DELETE' THEN 
            RAISE NOTICE 'O personagem % foi excluído da lista de personagens.', OLD.name;
            RETURN OLD;
        END CASE;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER check_char_change BEFORE INSERT OR UPDATE OR DELETE ON character_info 
FOR EACH ROW EXECUTE FUNCTION check_character_created();
