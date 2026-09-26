CREATE FUNCTION chapter_1() RETURNS VOID AS $$
BEGIN
    PERFORM print('Agora que você entrou na Universidade de Puramex, o primeiro passo como estudante é descobrir seu poder.');
    PERFORM pg_sleep(2);
    PERFORM print('No entanto, primeiro precisamos deixar algo claro.');
    PERFORM pg_sleep(2);

    PERFORM print('Há quatrocentos anos, o Império de Eden governava o planeta Nexus. Foi fundado por Numquam Vincar, meio humana, meio deusa, e desde então os cabelos ruivos são considerados sagrados, sinal de parentesco com ela.');
    PERFORM pg_sleep(3);
    PERFORM print('Quando o Império se partiu, cada fragmento passou a reivindicar a herança de Numquam Vincar. A guerra de sucessão que começou naquele dia nunca terminou.');
    PERFORM pg_sleep(3);
    PERFORM print('Cada nação nasceu de um descendente verdadeiro de Numquam Vincar, e todas as coroas têm o mesmo direito ao trono. Por isso nenhuma conquista encerra a guerra. Uma nação só cai quando morre o último herdeiro de sua linhagem.');
    PERFORM pg_sleep(3);
    PERFORM print('Só os nobres estudam nesta universidade e aprendem a controlar os elementos. O povo comum serve de peão nessa guerra.');
    PERFORM pg_sleep(3);
    PERFORM print('Hoje, cinco nações disputam o que restou de Eden:');
    PERFORM pg_sleep(2);

    PERFORM print('PURAMEX. A nação mais estável e pacífica de Nexus, feita de comércio, ordem e rotas mercantes. Mantém-se neutra na guerra e lucra vendendo para todos os lados. Sua família real nasce com cabelo rosa, uma mutação do ruivo de Numquam Vincar, e aposta em sobreviver a todas as outras. É aqui que fica a sua universidade.');
    PERFORM pg_sleep(3);
    PERFORM print('AUSTRISIA. Um arquipélago de corsários, portos e bandeiras roubadas, com cidades tomadas por crime e corrupção. Sua família real defende a herança de Numquam Vincar com canhões.');
    PERFORM pg_sleep(3);
    PERFORM print('FROST. A única facção fora de Nexus, num planeta frio e pacífico. Possui a maior frota espacial do universo, mas é desorganizada e demonstra pouco interesse em conquistar Nexus.');
    PERFORM pg_sleep(3);
    PERFORM print('MELLEGOTHICA. A nação mais avançada em tecnologia, e também a mais arrogante. Sua capital é uma cúpula no deserto de gelo do polo. Foi ela que construiu a bomba que destruiu Lygon, e muitos em Mellegothica ainda chamam isso de vitória.');
    PERFORM pg_sleep(3);
    PERFORM print('VENDETTA. O que sobrou de Lygon depois da bomba. A família real sobreviveu, e com ela a nação, hoje espalhada por Nexus e agindo nas sombras. Mesmo destruída, já houve assassinatos atribuídos a ela dentro da própria Mellegothica. Seus sobreviventes abandonaram o antigo nome e escolheram outro, para que ninguém esquecesse o que devem a Mellegothica.');
    PERFORM pg_sleep(3);

    PERFORM print('Então, estudante, de qual nação você vem? Para selecionar, explore as tabelas factions e character_allegiances');
    
END; $$ LANGUAGE PLPGSQL;
