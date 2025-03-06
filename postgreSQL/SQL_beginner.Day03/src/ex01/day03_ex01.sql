WITH step_one AS
	(SELECT DISTINCT menu_id
	FROM person_order
	ORDER BY menu_id)
SELECT menu.id AS menu_id
FROM menu
EXCEPT
SELECT step_one.menu_id
FROM step_one
ORDER BY menu_id;
