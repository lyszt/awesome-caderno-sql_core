CREATE TABLE races (
    id integer generated always as identity primary key,
    name varchar(20) NOT NULL,
    descriptor varchar(20),
    description text
);

INSERT INTO races (name, descriptor, description) VALUES
    ('Elfo de Sangue', 'orgulhoso', 'Uma raça élfica orgulhosa, marcada por olhos brilhantes e uma obsessão antiga por magia arcana. Poderosos, mas nunca satisfeitos.'),
    ('Humano', 'trabalhador', 'Sem talentos extraordinários, mas versátil e adaptável a qualquer situação. O que falta em especialização, sobra em determinação.'),
    ('Androide', 'preciso', 'Uma consciência artificial em um corpo mecânico, construído para precisão e resistência onde a carne humana falharia.'),
    ('Neko', 'ágil', 'Meio humano, meio felino. Ágil, curioso e tão perigoso em combate quanto charmoso fora dele.');
