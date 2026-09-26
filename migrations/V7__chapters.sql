

CREATE FUNCTION enter_chapter(chapter integer) RETURNS VOID AS $$
DECLARE
BEGIN
    CASE chapter
        WHEN 1 THEN
            PERFORM chapter_1();
        ELSE
            RAISE EXCEPTION 'Personagem não possui um capítulo selecionado.';
    END CASE;


END; $$ LANGUAGE PLPGSQL SECURITY DEFINER;