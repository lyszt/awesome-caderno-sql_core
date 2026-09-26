-- File made to create character templates, which makes testing easier instead of having to insert values

DROP TABLE IF EXISTS char_templates;
CREATE TABLE char_templates (LIKE character_info INCLUDING ALL);

INSERT INTO char_templates (name, description, class, gender, race) VALUES
('Lyszt Kaldwin',
 'Um Deestad que nunca empunhou a espada. Deixou a cidade onde nasceu por uma terra mais fria ao sul '
 'e trabalha como engenheiro, embora quase nunca termine algo no prazo. Acredita que, para assar pão do zero, '
 'é preciso primeiro inventar o mundo, por isso se recusa a usar ferramentas que não fez com as próprias mãos. Para construir uma carroça, primeiro forja o martelo, '
 'e para forjar o martelo, primeiro cava o minério. Seu Personal Core é fraco e só o deixa vislumbrar outras realidades por um instante, '
 'mas ele escolhe o caminho difícil de propósito, porque acha que compreender é a única coisa que vale a pena possuir. '
 'Em algumas noites, o fantasma da Lâmina Zenon aparece em sua oficina, e ele fica acordado até tarde demais tentando construir uma do nada.',
 5, 'masculino', 1);


 CREATE OR REPLACE FUNCTION use_template(char_id INTEGER) RETURNS VOID AS $$
 BEGIN
    INSERT INTO character_info (name,description, class, gender, race)
    SELECT name,description,class,gender,race FROM char_templates WHERE id = char_id;
 END; $$ LANGUAGE PLPGSQL;