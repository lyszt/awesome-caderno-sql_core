CREATE TABLE races (
    id integer generated always as identity primary key,
    name varchar(20) NOT NULL,
    name_female varchar(20) NOT NULL,
    descriptor varchar(20),
    descriptor_female varchar(20),
    description text
);

INSERT INTO races (name, name_female, descriptor, descriptor_female, description) VALUES
    ('Elfo de Sangue', 'Elfa de Sangue', 'orgulhoso', 'orgulhosa', 'Uma raça élfica orgulhosa, marcada por olhos brilhantes e uma obsessão antiga por magia arcana. Poderosos, mas nunca satisfeitos.'),
    ('Humano', 'Humana', 'trabalhador', 'trabalhadora', 'Sem talentos extraordinários, mas versátil e adaptável a qualquer situação. O que falta em especialização, sobra em determinação.'),
    ('Androide', 'Androide', 'preciso', 'precisa', 'Uma consciência artificial em um corpo mecânico, construído para precisão e resistência onde a carne humana falharia.'),
    ('Neko', 'Neko', 'ágil', 'ágil', 'Meio humano, meio felino. Ágil, curioso e tão perigoso em combate quanto charmoso fora dele.');
