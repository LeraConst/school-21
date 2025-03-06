WITH step_one AS 
	(SELECT pizzeria.name, gender
	FROM person_order
	JOIN person ON person_order.person_id = person.id
	JOIN menu ON person_order.menu_id = menu.id
	JOIN pizzeria ON menu.pizzeria_id = pizzeria.id),
step_male AS (SELECT name FROM step_one WHERE gender = 'male'),
step_female AS (SELECT name FROM step_one WHERE gender = 'female')

SELECT name AS pizzeria_name
FROM (
	(SELECT * FROM step_female
	EXCEPT
	SELECT * FROM step_male)
	UNION
	(SELECT * FROM step_male
	EXCEPT
	SELECT * FROM step_female)
	) AS people
ORDER BY pizzeria_name;