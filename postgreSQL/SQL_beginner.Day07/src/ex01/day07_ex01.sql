--В этом задании просят сортировку только по имени, но пример данных сортируется по визитам
WITH step_one AS (
	SELECT person_id, COUNT(id) AS count_of_visits
	FROM person_visits
	GROUP BY person_id
	ORDER BY count_of_visits DESC
	LIMIT 4
)
SELECT person.name, step_one.count_of_visits
FROM step_one
JOIN person ON step_one.person_id = person.id
ORDER BY count_of_visits DESC, name;