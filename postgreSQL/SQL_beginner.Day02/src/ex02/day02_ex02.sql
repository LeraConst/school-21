WITH step_one AS (SELECT person.name AS person_name, person_visits.visit_date AS visit_date, pizzeria.name AS pizzeria_name
	FROM person_visits
	LEFT JOIN pizzeria ON person_visits.pizzeria_id = pizzeria.id
	LEFT JOIN person ON person_visits.person_id = person.id
	WHERE person_visits.visit_date = '2022-01-01' OR person_visits.visit_date = '2022-01-02' OR person_visits.visit_date = '2022-01-03'),
step_two AS (SELECT person.name AS person_name, visit_date, pizzeria_name
			FROM step_one
			RIGHT JOIN person ON step_one.person_name = person.name),
step_three AS (SELECT person_name, visit_date, pizzeria.name AS pizzeria_name
			  FROM step_two
			  FULL JOIN pizzeria ON step_two.pizzeria_name = pizzeria.name)
SELECT COALESCE(person_name, '-') AS person_name, visit_date, COALESCE(pizzeria_name, '-') AS pizzeria_name
FROM step_three
ORDER BY person_name, visit_date, pizzeria_name