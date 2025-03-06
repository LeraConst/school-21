--Создаем таблицу
CREATE TABLE named_nodes (
  id SERIAL PRIMARY KEY,
  point1 VARCHAR(1),
  point2 VARCHAR(1),
  cost INTEGER);

--Заполняем таблицу необходимыми данными
INSERT INTO named_nodes (point1, point2, cost)
VALUES 
  ('a', 'b', 10),
  ('b', 'a', 10),
  ('b', 'c', 35),
  ('c', 'b', 35),
  ('c', 'd', 30),
  ('d', 'c', 30),
  ('c', 'a', 15),
  ('a', 'c', 15),
  ('b', 'd', 25),
  ('d', 'b', 25),
  ('a', 'd', 20),
  ('d', 'a', 20);
  
  --Находим пути с минимальной стоимостью
WITH tour AS (
  SELECT 'a' AS node1,
         x.node2 AS node2,
         y.node3 AS node3,
         z.node4 AS node4,
         'a' AS node5
  FROM unnest(array['b', 'c', 'd']) x(node2),
       unnest(array['b', 'c', 'd']) y(node3),
       unnest(array['b', 'c', 'd']) z(node4)
  WHERE x.node2 <> y.node3 AND 
        x.node2 <> z.node4 AND 
        y.node3 <> z.node4), 
last_tour AS (SELECT (SELECT sum(cost) 
                      FROM named_nodes 
                      WHERE (point1, point2) IN 
                       ((tour.node1, tour.node2), 
                        (tour.node2, tour.node3), 
                        (tour.node3, tour.node4), 
                        (tour.node4, tour.node5))) AS total_cost,
                     CONCAT('{', node1, ',', node2, ',', node3, ',', node4, ',', node5, '}') AS tour
              FROM tour)
              
SELECT *
FROM last_tour
WHERE total_cost = (SELECT MIN(total_cost) 
                    FROM last_tour)
ORDER BY total_cost, tour;
