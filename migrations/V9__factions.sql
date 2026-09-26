

-- Character Allegiances

CREATE TYPE reputation_types AS ENUM (
    'hated','hostile','unfriendly','neutral','friendly','honored','revered','exalted'
);

-- Factions 

DROP TABLE IF EXISTS factions;
CREATE TABLE factions(
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(20) NOT NULL UNIQUE,
    description TEXT,
    control_level FLOAT
);

INSERT INTO factions (name, description) VALUES
    ('Puramex', 'A nação mais estável e pacífica de Nexus, feita de comércio, ordem e rotas mercantes. Neutra na guerra de sucessão, lucra vendendo para todos os lados e dá abrigo à maior parte dos refugiados de Vendetta. Sua família real foi cruzada por gerações para preservar o sangue de Numquam Vincar, mas o ruivo sofreu uma mutação, e hoje seus descendentes nascem com cabelo rosa. Por trás da neutralidade, a coroa ainda sonha em vencer a guerra. Abriga a Universidade de Puramex, onde só os nobres estudam e aprendem a controlar os elementos, enquanto o povo comum serve de peão na guerra.'),
    ('Austrisia', 'Um arquipélago de corsários, portos e bandeiras roubadas, onde se fala uma língua própria, rápida e cantada. Suas cidades vivem tomadas por crime e corrupção, e ninguém sabe ao certo quem manda em cada porto. Suas famílias juram ter sangue de Numquam Vincar e defendem essa jura com canhões.'),
    ('Frost', 'A única facção fora de Nexus, num planeta frio e pacífico. Possui a maior frota espacial do universo, mas é desorganizada e pouco interessada em conquistar Nexus. Seus guerreiros preferem um bom duelo a uma conquista, e costumam tratar os rivais como amigos.'),
    ('Mellegothica', 'A nação mais avançada em tecnologia, e também a mais arrogante. Sua capital é uma cúpula no meio do deserto de gelo do polo, que gera calor e colheitas onde nada deveria crescer. Seus nobres formam uma elite esnobe que despreza o resto de Nexus, e muitas de suas famílias tratam a nação como obrigação de nascença. Delas saíram alguns dos guerreiros mais fortes de Nexus, capazes de controlar Solynus, o poder do sol. Construiu a bomba que destruiu Lygon, e muitos de seus cidadãos ainda chamam isso de vitória.'),
    ('Vendetta', 'O que sobrou de Lygon depois da bomba. Seu povo vive espalhado por Nexus, e a maior parte dos refugiados está em Puramex. São dedicados e disciplinados, e trocaram o antigo nome por outro para que ninguém esqueça o que devem a Mellegothica. Sua família real é a única com o ruivo puro de Numquam Vincar, e ainda recebe desertores de outras nações que juram a mesma vingança.');

DROP TABLE IF EXISTS character_allegiances;
CREATE TABLE character_allegiances (
    entity_id INTEGER REFERENCES character_info(id) ON DELETE CASCADE NOT NULL,
    faction_id INTEGER REFERENCES factions(id) ON DELETE CASCADE NOT NULL
);


