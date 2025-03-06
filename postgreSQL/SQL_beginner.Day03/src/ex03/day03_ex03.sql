WITH step_one AS 
	(SELECT pizzeria.name, gender
	FROM person_visits
	JOIN person ON person_visits.person_id = person.id
	JOIN pizzeria ON person_visits.pizzeria_id = pizzeria.id),
step_male AS (SELECT name FROM step_one WHERE gender = 'male'),
step_female AS (SELECT name FROM step_one WHERE gender = 'female')

SELECT name AS pizzeria_name
FROM (
	(SELECT *
	FROM step_male
	EXCEPT ALL
	SELECT *
	FROM step_female)
	UNION ALL
	(SELECT *
	FROM step_female
	EXCEPT ALL
	SELECT *
	FROM step_male)
	) AS test
ORDER BY pizzeria_name;