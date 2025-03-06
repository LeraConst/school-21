WITH step_menu AS (
	SELECT menu.pizzeria_id, menu.price
	FROM person_order
	JOIN menu ON person_order.menu_id = menu.id
	),
	step_price AS (
	SELECT pizzeria_id, ROUND(AVG(price), 2) AS average_price, MAX(price) AS max_price, MIN(price) AS min_price
	FROM step_menu
	GROUP BY pizzeria_id
	),
	step_orders AS (
	SELECT pizzeria.id, COUNT(person_order.id) AS count_of_orders
	FROM person_order
	JOIN menu ON person_order.menu_id = menu.id
	JOIN pizzeria ON menu.pizzeria_id = pizzeria.id
	GROUP BY pizzeria.id
	ORDER BY name, count_of_orders DESC
	),
	step_union AS (
	SELECT pizzeria.name, step_orders.count_of_orders, step_price.average_price, step_price.max_price, step_price.min_price
	FROM step_orders
	JOIN pizzeria ON step_orders.id = pizzeria.id
	JOIN step_price ON step_orders.id = step_price.pizzeria_id
	)
SELECT *
FROM step_union
ORDER BY name;