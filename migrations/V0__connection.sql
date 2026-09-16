
CREATE OR REPLACE FUNCTION link_start() RETURNS event_trigger AS $$
BEGIN
    RAISE NOTICE 'Seja bem vindo ao Awesome Caderno Online, o mais novo MMORPG de realidade virtual.';
    PERFORM pg_sleep(2);
    RAISE NOTICE 'Você coloca o seu capacete de realidade virtual e se conecta ao jogo.';
    PERFORM pg_sleep(2);
    RAISE NOTICE 'LINK START!';
    PERFORM pg_sleep(2);
    RAISE NOTICE E'Para começar, você deve criar seu personagem. Você abre a tela de criação de personagem.\n.
    Para criar seu personagem, insira um novo personagem na tabela *character_info*.';
    RAISE NOTICE 'Precisa de ajuda? Use SELECT * FROM help; a qualquer momento para ver dicas.';

END; $$ LANGUAGE plpgsql;


DROP EVENT TRIGGER IF EXISTS on_login;
CREATE EVENT TRIGGER on_login ON login EXECUTE FUNCTION link_start();

