WITH step_one AS 
	(SELECT male.name
	FROM person_order
	JOIN (SELECT person.name, person.id
		FROM person
		WHERE gender = 'male' AND (address = 'Moscow' OR address = 'Samara')) AS male
 	ON male.id = person_order.person_id
	JOIN menu ON person_order.menu_id = menu.id
	WHERE menu.pizza_name = 'mushroom pizza' OR menu.pizza_name = 'pepperoni pizza')
SELECT *
FROM step_one
ORDER BY name DESC;