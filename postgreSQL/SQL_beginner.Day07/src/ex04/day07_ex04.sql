WITH step_visits AS (
	SELECT person.name, COUNT(person_visits.id) AS total_visits
	FROM person_visits
	JOIN person ON person_visits.person_id = person.id
	GROUP BY person.name 
	HAVING COUNT(pizzeria_id) > 3
	)
SELECT *
FROM step_visits;