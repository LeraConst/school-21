WITH step_one AS
	(SELECT DISTINCT menu_id
	FROM person_order
	ORDER BY menu_id),
step_two AS
	(SELECT menu.id AS menu_id
	FROM menu
	EXCEPT
	SELECT step_one.menu_id
	FROM step_one
	ORDER BY menu_id)
SELECT menu.pizza_name, menu.price, pizzeria.name AS pizzeria_name
FROM menu
JOIN step_two ON menu.id = step_two.menu_id
JOIN pizzeria ON menu.pizzeria_id = pizzeria.id
ORDER BY pizza_name, price;