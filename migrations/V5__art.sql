DROP TABLE IF EXISTS art;
CREATE TABLE art (
    name VARCHAR(30) PRIMARY KEY,
    content TEXT NOT NULL
);

INSERT INTO art (name, content) VALUES
    ('link_start', $art$
 _      ___  _   _  _  __   ____   _____     _     ____   _____
| |    |_ _|| \ | || |/ /  / ___| |_   _|   / \   |  _ \ |_   _|
| |     | | |  \| || ' /   \___ \   | |    / _ \  | |_) |  | |
| |___  | | | |\  || . \    ___) |  | |   / ___ \ |  _ <   | |
|_____||___||_| \_||_|\_\  |____/   |_|  /_/   \_\|_| \_\  |_|
$art$);

CREATE OR REPLACE FUNCTION show_art(p_name VARCHAR) RETURNS VOID AS $$
DECLARE
    art_content TEXT;
BEGIN
    SELECT content INTO art_content FROM art WHERE name = p_name;
    IF NOT FOUND THEN
        RAISE NOTICE 'A arte % não foi encontrada.', p_name;
        RETURN;
    END IF;
    RAISE NOTICE '%', art_content;
END;
$$ LANGUAGE plpgsql;

DROP TABLE IF EXISTS animation;
CREATE TABLE animation (
    name VARCHAR(30) NOT NULL,
    frame_id INTEGER NOT NULL,
    content TEXT NOT NULL,
    PRIMARY KEY (name, frame_id)
);

INSERT INTO animation (name, frame_id, content)
SELECT 'loading', n, '[' || repeat('#', n * 2) || repeat('-', 20 - n * 2) || ']'
FROM generate_series(1, 10) AS n;

CREATE OR REPLACE FUNCTION play_animation(p_name VARCHAR, p_delay DOUBLE PRECISION DEFAULT 0.3) RETURNS VOID AS $$
DECLARE
    frame RECORD;
BEGIN
    FOR frame IN SELECT content FROM animation WHERE name = p_name ORDER BY frame_id LOOP
        PERFORM clean_frame();
        RAISE NOTICE '%', frame.content;
        PERFORM pg_sleep(p_delay);
    END LOOP;
    IF NOT FOUND THEN
        RAISE NOTICE 'A animação % não foi encontrada.', p_name;
    END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION clean_frame() RETURNS VOID AS $$
BEGIN
    RAISE NOTICE E'\033[H\033[2J';
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION show_characters() RETURNS VOID AS $$
DECLARE
    border TEXT := '+' || repeat('-', 56) || '+';
    header TEXT := format('| %-3s %-20s %-16s %-12s |', 'ID', 'NOME', 'RAÇA', 'CLASSE');
    char_rows TEXT;
BEGIN
    SELECT string_agg(format('| %-3s %-20s %-16s %-12s |', c.id, c.name, d.race, d.class), E'\n' ORDER BY c.id)
    INTO char_rows
    FROM character_info c
    CROSS JOIN LATERAL get_gender_descriptors(c) d;

    IF char_rows IS NULL THEN
        char_rows := format('| %-54s |', 'Nenhum personagem foi criado ainda.');
    END IF;

    RAISE NOTICE E'%\n%\n%\n%\n%', border, header, border, char_rows, border;
END;
$$ LANGUAGE plpgsql;