WITH step_one AS
	(SELECT my_menu.pizza_name, my_menu.price, pizzeria.name AS pizzeria_name, person_visits.visit_date
	FROM person_visits
	JOIN (SELECT id
		 FROM person
		 WHERE name = 'Kate') AS kate
	ON person_visits.person_id = kate.id
	JOIN pizzeria ON person_visits.pizzeria_id = pizzeria.id
	JOIN (SELECT menu.pizza_name, menu.price, menu.pizzeria_id
		 FROM menu
		 WHERE price >= 800 AND price <= 1000) AS my_menu
	ON pizzeria.id = my_menu.pizzeria_id)
SELECT *
FROM step_one
ORDER BY pizza_name, price, pizzeria_name;