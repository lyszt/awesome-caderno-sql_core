-- Utility functions


CREATE OR REPLACE FUNCTION type_line(content text)
RETURNS VOID AS $$
BEGIN
    RAISE NOTICE '%', left(content, 1);
    for position in 2..length(content) LOOP
        RAISE NOTICE E'\033[1A\033[2K%', left(content, position);
        PERFORM pg_sleep(0.03);
    END LOOP;

END; $$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION print(content text)
RETURNS VOID AS $$
DECLARE
    width CONSTANT integer := 70;
    line text := '';
    word text;
BEGIN
    FOREACH word IN ARRAY regexp_split_to_array(content, '\s+') LOOP
        IF line <> '' AND length(line) + 1 + length(word) > width THEN
            PERFORM type_line(line);
            line := word;
        ELSIF line = '' THEN
            line := word;
        ELSE
            line := line || ' ' || word;
        END IF;
    END LOOP;
    PERFORM type_line(line);

END; $$ LANGUAGE PLPGSQL;
