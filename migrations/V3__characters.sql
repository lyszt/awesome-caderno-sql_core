

DROP TYPE IF EXISTS genders;
CREATE TYPE genders AS ENUM('masculino', 'feminino');


DROP TABLE IF EXISTS character_info;
CREATE TABLE character_info (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(20) UNIQUE,
    description TEXT,
    class INTEGER NOT NULL REFERENCES classes(id),
    gender genders NOT NULL,
    race INTEGER NOT NULL REFERENCES races(id)
);


DROP TYPE IF EXISTS player_states ;
CREATE TYPE player_states AS ENUM(
    'exploring','battle','dead'
);


DROP TABLE IF EXISTS character_states;
CREATE TABLE character_states(
    player_id INTEGER REFERENCES character_info(id)  ON DELETE CASCADE NOT NULL,
    state player_states NOT NULL,
    chapter_id INTEGER NOT NULL
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
    gender_descriptors RECORD;

BEGIN  
    CASE TG_OP
        WHEN 'INSERT' THEN
            SELECT * INTO gender_descriptors FROM get_gender_descriptors(NEW);
            IF NOT FOUND THEN
                RAISE NOTICE 'Infelizmente, nesse momento os únicos gêneros são masculino e feminino.';
                RETURN NULL;
            END IF;
            SELECT * INTO char_race FROM races WHERE races.id = NEW.race;
            SELECT * INTO char_class FROM classes WHERE classes.id = NEW.class;
            EXECUTE format('CREATE ROLE %I LOGIN PASSWORD %L IN GROUP player', lower(NEW.name), lower(NEW.name));
            PERFORM play_animation('loading');
            RAISE NOTICE 'Parabéns, você criou seu personagem.';
            PERFORM pg_sleep(2);
            RAISE NOTICE 'Seu personagem é %, % % da % raça dos %s.', NEW.name, gender_descriptors.indefinite_article, gender_descriptors.class, gender_descriptors.descriptor, gender_descriptors.race;
            RETURN NEW;
        WHEN 'UPDATE' THEN
            RAISE NOTICE 'Personagens não podem ser alterados depois de criados.';
            RETURN OLD;
        WHEN 'DELETE' THEN 
            DELETE FROM character_states WHERE player_id = OLD.id;
            EXECUTE format('DROP ROLE %I', OLD.name);
            RAISE NOTICE 'O personagem % foi excluído da lista de personagens.', OLD.name;
            RETURN OLD;
        END CASE;

END;
$$ LANGUAGE plpgsql;

-- Gender descriptors
 CREATE OR REPLACE FUNCTION get_gender_descriptors(p_char character_info)
  RETURNS TABLE (race VARCHAR, class VARCHAR, descriptor VARCHAR, article TEXT,
  indefinite_article TEXT) AS $$
  BEGIN
      CASE p_char.gender
          WHEN 'masculino' THEN
              RETURN QUERY
              SELECT r.name, cl.name, r.descriptor, 'o', 'um'
              FROM races r, classes cl
              WHERE r.id = p_char.race AND cl.id = p_char.class;
          WHEN 'feminino' THEN
              RETURN QUERY
              SELECT r.name_female, cl.name_female, r.descriptor_female, 'a', 'uma'
              FROM races r, classes cl
              WHERE r.id = p_char.race AND cl.id = p_char.class;
          ELSE
              RETURN;
      END CASE;
  END;
  $$ LANGUAGE plpgsql;

-- These functions are done after creation. The ones put here can't be done in a BEFORE trigger
-- jack
CREATE OR REPLACE FUNCTION perform_character_configuration() RETURNS TRIGGER AS $$
BEGIN
 CASE TG_OP
        WHEN 'INSERT' THEN
            INSERT INTO character_states(player_id, state, chapter_id) VALUES (NEW.id, 'exploring',1);
            PERFORM clean_frame();
            PERFORM show_characters();
            RETURN NEW;
        ELSE
            RETURN NULL;
            -- rn doesn't do anything on other cases
        END CASE;
END; $$ LANGUAGE plpgsql;


CREATE OR REPLACE TRIGGER check_char_change BEFORE INSERT OR UPDATE OR DELETE ON character_info 
FOR EACH ROW EXECUTE FUNCTION check_character_created();

CREATE OR REPLACE TRIGGER configure_char AFTER INSERT OR UPDATE OR DELETE ON character_info 
FOR EACH ROW EXECUTE FUNCTION perform_character_configuration();