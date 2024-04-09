-- 1 - get average price of every vendor's game
SELECT vendor_name, AVG(price)
FROM vendor_offerings vo JOIN vendor ON vo.vendor_id = vendor.id
GROUP BY vendor_name;

-- 2 - what is the cheapest game
SELECT game_name, price
FROM game INNER JOIN vendor_offerings vo on game.id = vo.game_id
WHERE price = (select min(price) from vendor_offerings);

-- 3 - list games under 1000 rubles
WITH pricing AS (SELECT game_id, game_name, vendor_id, price
                      FROM game INNER JOIN vendor_offerings vo on game.id = vo.game_id)
SELECT game_name, MIN(price)
FROM pricing
GROUP BY game_name
HAVING MIN(price) < 1000
ORDER BY MIN(price);

-- 4 - what games person 1 has
SELECT game_name
FROM (game
    inner join (
        person inner join game_ownership go on person.id = go.person_id
        ) as _ ON game.id = _.game_id) as ownership
WHERE person_id = 1;

-- 5 - who owns game number 5
SELECT name
FROM (game
    inner join (
        person inner join game_ownership go on person.id = go.person_id
        ) as _ ON game.id = _.game_id) as ownership
WHERE game_id = 5;

-- 6 - what game could 1 2 and 3 play together
SELECT DISTINCT game_name
FROM (SELECT *
      FROM ((game_ownership go join person p on p.id = go.person_id) o
          join game g on o.game_id = g.id) as ownership
      WHERE min_players >= 3) as games_for_three
WHERE person_id = ANY ('{4, 2, 3}'::int[]);

-- 7 - who can show up at 22 o'clock for an hour long game
SELECT DISTINCT name, second_name
FROM person
         JOIN time_spaces ts on person.id = ts.person_id
WHERE ts.period_start <= '22:00:00'
  and (ts.period_end >= '23:00:00' or ts.period_end < ts.period_start)
ORDER BY name;

-- 8 - which vendor offers game 14 for the cheapest
SELECT vendor_name, price
FROM (vendor INNER JOIN
    (SELECT * FROM (game INNER JOIN vendor_offerings v on game.id = v.game_id) WHERE game_id = 14) as vo
      on vendor.id = vo.vendor_id) offers
WHERE price = (SELECT min(price) from vendor_offerings where game_id = 14);

-- 9 - how much person 1 spent on games
SELECT SUM(lp) as total
FROM ((SELECT *
       FROM (game
           inner join (
               person inner join game_ownership go on person.id = go.person_id
               ) as _ ON game.id = _.game_id) as ownership
       WHERE person_id = 1) as posessions JOIN
    (SELECT *
     FROM (vendor INNER JOIN
         (SELECT game_id, vendor_id, MIN(price) OVER (PARTITION BY game_id) as lp
          FROM game
                   INNER JOIN vendor_offerings v on game.id = v.game_id) as vo
           on vendor.id = vo.vendor_id)) as offers ON posessions.game_id = offers.game_id
         );
-- 10 - who spent the most on games
WITH possesions as (SELECT *
                    FROM (game join (
                        person join game_ownership go on person.id = go.person_id
                        ) as _ ON game.id = _.game_id) as ownership),
     lowest_prices as (SELECT *
                       FROM (vendor INNER JOIN
                           (SELECT game_id, vendor_id, MIN(price) OVER (PARTITION BY game_id) as lp
                            FROM game
                                     INNER JOIN vendor_offerings v on game.id = v.game_id) as vo
                             on vendor.id = vo.vendor_id)),
     total_possesions as (SELECT distinct person_id, name, second_name, SUM(lp) OVER (PARTITION BY person_id) AS total
                          FROM (possesions JOIN lowest_prices on possesions.game_id = lowest_prices.game_id))
SELECT name, second_name, total
FROM total_possesions
WHERE total_possesions.total = (SELECT MAX(total_possesions.total) from total_possesions) ;

--

