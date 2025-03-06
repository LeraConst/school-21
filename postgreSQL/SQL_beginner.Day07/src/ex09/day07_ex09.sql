WITH step_age AS (
	SELECT address, ROUND(ROUND(MAX(age),2) - (ROUND(MIN(age),2) / ROUND(MAX(age),2)),2) AS formula, ROUND(AVG(age), 2) AS average
	FROM person
	GROUP BY address
	)
SELECT *,
    CASE
        WHEN formula > average THEN true
        ELSE false
    END AS comparison
FROM
    step_age
ORDER BY
    address;