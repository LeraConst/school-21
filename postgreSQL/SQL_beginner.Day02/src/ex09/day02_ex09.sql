WITH step_one AS 
	(SELECT female.name
	FROM person_order
	JOIN (SELECT person.name, person.id
		FROM person
		WHERE gender = 'female') AS female
 	ON female.id = person_order.person_id
	JOIN menu ON person_order.menu_id = menu.id
	WHERE menu.pizza_name = 'cheese pizza' OR menu.pizza_name = 'pepperoni pizza'
	GROUP BY female.name
	HAVING COUNT(DISTINCT menu.pizza_name) = 2)
SELECT *
FROM step_one
ORDER BY name;