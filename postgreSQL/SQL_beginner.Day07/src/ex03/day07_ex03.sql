WITH step_visits AS (
	SELECT pizzeria.name, COUNT(person_visits.id) AS total_count
	FROM person_visits
	JOIN pizzeria ON person_visits.pizzeria_id = pizzeria.id
	GROUP BY pizzeria.name
	),
	step_order AS (
	SELECT pizzeria.name, COUNT(person_order.id) AS total_count
	FROM person_order
	JOIN menu ON person_order.menu_id = menu.id
	JOIN pizzeria ON menu.pizzeria_id = pizzeria.id
	GROUP BY pizzeria.name
	),
	step_union AS (
	SELECT name, total_count
	FROM step_visits
	UNION ALL
	SELECT name, total_count
	FROM step_order
	)
SELECT name, SUM(total_count) AS total_count
FROM step_union
GROUP BY name
ORDER BY total_count DESC, name;