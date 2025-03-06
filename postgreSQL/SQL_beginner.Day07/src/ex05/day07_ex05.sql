WITH step_orders AS (
	SELECT person.name
	FROM person_order
	JOIN person ON person_order.person_id = person.id
	)
SELECT DISTINCT(name) AS name
FROM step_orders
ORDER BY name;