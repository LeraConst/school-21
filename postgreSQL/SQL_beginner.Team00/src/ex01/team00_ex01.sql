--Находим все пути
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
        y.node3 <> z.node4)
 
SELECT (SELECT sum(cost) 
        FROM named_nodes 
        WHERE (point1, point2) IN 
         ((tour.node1, tour.node2), 
          (tour.node2, tour.node3), 
          (tour.node3, tour.node4), 
          (tour.node4, tour.node5))) AS total_cost,
       CONCAT('{', node1, ',', node2, ',', node3, ',', node4, ',', node5, '}') AS tour
FROM tour
ORDER BY total_cost, 
         tour;
