-- We use this table to let the players have some tips of how to do basic operations

DROP TABLE IF EXISTS help;
CREATE TABLE help (
    id integer generated always as identity primary key,
    tip text
);

INSERT INTO help (tip) VALUES
    ('Para inserir um personagem, use INSERT INTO character_info (name, description, class, race) VALUES (''seu nome'', ''uma descrição'', x, x);'),
    ('Para encontrar sua classe e raça, procure as tabelas classes e races.'),
    ('Use SELECT * FROM races; e SELECT * FROM classes; para ver os ids disponíveis antes de criar seu personagem.'),
    ('Sem ideias? Use SELECT * FROM char_templates; para ver personagens prontos e SELECT use_template(id); para criar um deles.'),
    ('Depois de criado, seu personagem não pode ser alterado. Pense bem na hora de criar. Se precisar mudar algo, apague o personagem e crie um novo.'),
    ('Digite \q para sair do jogo.'),
    ('Use \dt para ver todas as tabelas do jogo.'),
    ('Use \d character_info para ver as colunas de uma tabela.'),
    ('Rumores dizem que certas raças têm afinidade com certas classes...');
