CREATE VIEW v_generated_dates AS
SELECT gen_date AS generated_date
FROM (
	SELECT generate_series('2022-01-01'::date, '2022-01-31'::date, '1 day'::interval)::date AS gen_date
	) AS gen
ORDER BY generated_date;