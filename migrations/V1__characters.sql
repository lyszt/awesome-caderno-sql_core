

DROP TABLE IF EXISTS character_info;
CREATE TABLE character_info (
    id integer generated always as identity primary key,
    name varchar(20),
    description text,
    class integer,
    race integer
);


CREATE OR REPLACE FUNCTION check_character_created() RETURNS TRIGGER AS $$
BEGIN

    CASE TG_OP
        WHEN 'INSERT' THEN
            RAISE NOTICE 'Parabéns, você criou % com sucesso.', NEW.name;
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