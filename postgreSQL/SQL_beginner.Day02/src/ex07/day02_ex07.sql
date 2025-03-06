WITH step_one AS
	(SELECT name AS pizzeria_name, menu.pizza_name
	 FROM pizzeria
	 JOIN
	(SELECT pizzeria_id
	FROM person_visits
	JOIN (SELECT id
		 FROM person
		 WHERE name = 'Dmitriy') AS dima ON person_visits.person_id = dima.id
	 WHERE visit_date = '2022-01-08') AS pizzeria_vis ON pizzeria.id = pizzeria_vis.pizzeria_id
	JOIN menu ON pizzeria.id = menu.pizzeria_id
	WHERE price < 800)
SELECT *
FROM step_one;