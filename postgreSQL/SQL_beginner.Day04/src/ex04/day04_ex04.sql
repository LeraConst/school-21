CREATE VIEW v_symmetric_union AS
WITH tabl_r AS (
	SELECT person_id
	FROM person_visits
	WHERE visit_date < '2022-01-02'),
tabl_s AS (
	SELECT person_id
	FROM person_visits
	WHERE visit_date < '2022-01-06')
SELECT person_id
FROM (
		(SELECT * FROM tabl_r EXCEPT SELECT * FROM tabl_s)
		 UNION 
		(SELECT * FROM tabl_s EXCEPT SELECT * FROM tabl_r)
	) AS nu_takoe
ORDER BY person_id;