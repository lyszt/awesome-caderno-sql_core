-- File made to create character templates, which makes testing easier instead of having to insert values

DROP TABLE IF EXISTS char_templates;
CREATE TABLE char_templates (LIKE character_info INCLUDING ALL);

INSERT INTO char_templates (name, description, class, gender, race) VALUES
-- 1: Guerreiro
('Aurelia de Austrisia',
'Filha de uma família de corsários de Austrisia que jura descender de Numquam Vincar, embora o cabelo dela seja mais castanho do que ruivo. '
'Aprendeu a lutar no convés antes de aprender etiqueta, e ainda não aprendeu etiqueta. '
'O pai a mandou à Universidade de Puramex para voltar com diploma e boas maneiras, '
'mas ela suspeita que o verdadeiro motivo é descobrir quais navios mercantes de Puramex valem a pena saquear.',
1, 'feminino', 1),

-- 2: Mago
('Soren Vael',
'Nasceu em Mellegothica, onde todos estudam máquinas e ninguém leva a magia a sério. '
'Cresceu ouvindo que a bomba que destruiu Lygon foi a maior conquista da sua nação, e em algum momento parou de acreditar nisso. '
'Escolheu estudar magia em Puramex em parte por curiosidade e em parte para ficar longe dos laboratórios de casa. '
'Estuda cada feitiço durante meses antes de tentar conjurá-lo, e mesmo assim quase sempre erra na primeira vez.',
2, 'masculino', 1),

-- 3: Ladino
('Vesper Umbra',
'Veio de Frost, o planeta frio e pacífico que tem a maior frota do universo e nenhum interesse em Nexus. '
'Achava a vida em casa tranquila demais, então se escondeu num cargueiro da frota e desceu em Nexus sem permissão de ninguém. '
'Ninguém sabe como ela conseguiu uma vaga na Universidade de Puramex, e ela prefere que continue assim. '
'Rouba pequenas coisas dos colegas só para devolvê-las depois, e ainda não decidiu se isso é um hábito ou um treino.',
3, 'feminino', 1),

-- 4: Clérigo
('Tobias Lumen',
'Nasceu em Puramex, a poucas ruas da universidade, e é o único da turma que nunca precisou atravessar uma fronteira. '
'Foi criado num templo que reza pelo fim da guerra há quatrocentos anos, numa cidade que enriquece vendendo para os dois lados dela. '
'Entrou na universidade para descobrir se é possível ser neutro sem ser cúmplice. '
'É gentil com todos, e os outros alunos desconfiam dele exatamente por isso.',
4, 'masculino', 1),

-- 5: Engenheiro
('Deestad',
'Originalmente nascido em Mellegothica, Deestad traiu sua cidade natal e o próprio irmão para se juntar a Vendetta, '
'tudo por causa de uma garota chamada Yoshida Lo''Ren, e até hoje não sabe dizer se valeu a pena. '
'Agora estuda engenharia em Puramex, embora quase nunca termine algo no prazo. Acredita que, para assar pão do zero, '
'é preciso primeiro inventar o mundo, por isso se recusa a usar ferramentas que não fez com as próprias mãos. '
'Para construir uma carroça, primeiro forja o martelo, e para forjar o martelo, primeiro cava o minério. '
'Escolhe o caminho difícil de propósito, não porque goste, mas porque acredita que só aprende de verdade aquilo que o faz sofrer. '
'Em algumas noites, o fantasma da Lâmina de Zenon aparece em sua oficina, e ele fica acordado até tarde demais tentando construir uma do nada.',
5, 'masculino', 1);

 CREATE OR REPLACE FUNCTION use_template(char_id INTEGER) RETURNS VOID AS $$
 BEGIN
    INSERT INTO character_info (name,description, class, gender, race)
    SELECT name,description,class,gender,race FROM char_templates WHERE id = char_id;
 END; $$ LANGUAGE PLPGSQL;