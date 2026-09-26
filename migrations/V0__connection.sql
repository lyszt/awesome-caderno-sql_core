
CREATE OR REPLACE FUNCTION link_start() RETURNS event_trigger AS $$
DECLARE
    character_count INTEGER;
BEGIN
    IF user = 'rpg' THEN
            SELECT INTO character_count count(*) FROM character_info;
            PERFORM print('Depois de uma longa viagem, você finalmente avista as torres da Universidade de Puramex.');
            PERFORM pg_sleep(2);
            PERFORM print('Você mostra sua carta de admissão aos guardas e atravessa os portões.');
            PERFORM play_animation('loading', 0.15);
            PERFORM show_art('link_start');
            PERFORM pg_sleep(2);
            PERFORM clean_frame();
            IF character_count <= 0 THEN
                PERFORM print(E'Para começar, você deve se apresentar. Um funcionário da secretaria entrega a sua ficha de matrícula.');
                PERFORM print('Para criar seu personagem, insira um novo personagem na tabela *character_info*.');
                PERFORM print('Precisa de ajuda? Use SELECT * FROM help; a qualquer momento para ver dicas.');
            ELSE
                PERFORM print('Use \c rpg {nome_do_personagem}, em minusculo para se conectar em qualquer personagem. (A senha é o nome do personagem)');
            END IF;
            PERFORM show_characters();
    ELSE 
        PERFORM print('Você olha em seus arredores.');
        
        PERFORM (
            WITH char_state AS (
                SELECT cs.chapter_id
                FROM character_info c
                JOIN character_states cs ON cs.entity_id = c.id
                WHERE lower(name) = current_user
            )
            SELECT enter_chapter(chapter_id) FROM char_state
        );

    END IF;

END; $$ LANGUAGE plpgsql;


DROP EVENT TRIGGER IF EXISTS on_login;
CREATE EVENT TRIGGER on_login ON login EXECUTE FUNCTION link_start();

