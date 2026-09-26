-- File made to create character templates, which makes testing easier instead of having to insert values

DROP TABLE IF EXISTS char_templates;
CREATE TABLE char_templates (LIKE character_info INCLUDING ALL);

INSERT INTO char_templates (name, description, class, gender, race) VALUES
('Lyszt Kaldwin',
 'A Deestad who never picked up the sword. He left the city of his birth for a colder land in the south '
 'and works as an engineer, though he rarely finishes anything on time. He believes that to bake bread from scratch '
 'you must first invent the world, so he refuses to use tools he did not make himself. To build a cart he first forges the hammer, '
 'and to forge the hammer he first digs the ore. His Personal Core is weak and only lets him glimpse other realities for a moment, '
 'but he chooses the hard road on purpose, because he thinks understanding is the only thing worth owning. '
 'Some nights the ghost of the Blade Zenon shows up in his workshop, and he stays up far too late trying to build one from nothing.',
 5, 'masculino', 1);


 CREATE OR REPLACE FUNCTION use_template(char_id INTEGER) RETURNS VOID AS $$
 BEGIN
    INSERT INTO character_info (name,description, class, gender, race)
    SELECT name,description,class,gender,race FROM char_templates WHERE id = char_id;
 END; $$ LANGUAGE PLPGSQL;