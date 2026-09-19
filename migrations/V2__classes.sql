CREATE TABLE classes (
    id integer generated always as identity primary key,
    name varchar(20) NOT NULL,
    name_female varchar(20) NOT NULL,
    description text
);

INSERT INTO classes (name, name_female, description) VALUES
    ('Guerreiro', 'Guerreira', 'Força bruta e aço. Entra na linha de frente e resolve a maioria dos problemas na marra.'),
    ('Mago', 'Maga', 'Domina as artes arcanas, trocando resistência física por poder devastador à distância.'),
    ('Ladino', 'Ladina', 'Rápido, discreto e mortal em corpo a corpo. Prefere resolver as coisas antes do inimigo perceber.'),
    ('Clérigo', 'Clériga', 'Canaliza energia divina para curar aliados e afastar os mortos-vivos.'),
    ('Engenheiro', 'Engenheira', 'Constrói e modifica equipamentos e gadgets, trocando magia por engenhocas.'),
    ('Bardo', 'Barda', 'Inspira aliados e atordoa inimigos com música, contando com carisma onde outros contam com força.');
