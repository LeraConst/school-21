WITH gen AS (SELECT generate_series('2022-01-01'::date, '2022-01-10'::date, '1 day'::interval)::date AS missing_date)
SELECT missing_date
FROM gen
LEFT JOIN (SELECT visit_date
		  FROM person_visits
		  WHERE person_id = 1 OR person_id = 2) AS visits 
ON gen.missing_date = visits.visit_date
WHERE visits IS NULL
ORDER BY gen.missing_date;