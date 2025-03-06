WITH step_one AS
	(SELECT pizza_name, pizzeria.name AS pizzeria_name, price
	FROM menu
	JOIN pizzeria ON menu.pizzeria_id = pizzeria.id)
SELECT
	fir.pizza_name AS pizza_name,
	fir.pizzeria_name AS pizzeria_name_1,
	sec.pizzeria_name AS pizzeria_name_2,
	fir.price AS price
FROM step_one AS fir
JOIN step_one AS sec ON fir.pizza_name = sec.pizza_name
AND fir.pizzeria_name < sec.pizzeria_name
WHERE fir.price = sec.price
ORDER BY pizza_name;