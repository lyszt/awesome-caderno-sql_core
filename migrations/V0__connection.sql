
CREATE OR REPLACE FUNCTION link_start() RETURNS event_trigger AS $$
DECLARE
    character_count INTEGER;
BEGIN
    IF user = 'rpg' THEN
            SELECT INTO character_count count(*) FROM character_info;
            RAISE NOTICE 'Seja bem vindo ao Awesome Caderno Online, o mais novo MMORPG de realidade virtual.';
            PERFORM pg_sleep(2);
            RAISE NOTICE 'Você coloca o seu capacete de realidade virtual e se conecta ao jogo.';
            PERFORM play_animation('loading', 0.15);
            PERFORM show_art('link_start');
            PERFORM pg_sleep(2);
            PERFORM clean_frame();
            IF character_count <= 0 THEN
                RAISE NOTICE E'Para começar, você deve criar seu personagem. Você abre a tela de criação de personagem.';
                RAISE NOTICE 'Para criar seu personagem, insira um novo personagem na tabela *character_info*.';
                RAISE NOTICE 'Precisa de ajuda? Use SELECT * FROM help; a qualquer momento para ver dicas.';
            ELSE
                RAISE NOTICE 'Use \c rpg {nome_do_personagem}, em minusculo para se conectar em qualquer personagem. (A senha é o nome do personagem)';
            END IF;
            PERFORM show_characters();
    ELSE 
        RAISE NOTICE 'Você está conectado ao mundo de Awesome Caderno Online.';
    END IF;

END; $$ LANGUAGE plpgsql;


DROP EVENT TRIGGER IF EXISTS on_login;
CREATE EVENT TRIGGER on_login ON login EXECUTE FUNCTION link_start();

