INSERT INTO person_order values (
	(SELECT MAX(id)+1 FROM person_order),
	(SELECT id FROM person WHERE name = 'Denis'),
	(SELECT id FROM menu WHERE pizza_name = 'Sicilian pizza'),
	'2022-02-24');

INSERT INTO person_order values (
	(SELECT MAX(id)+1 FROM person_order),
	(SELECT id FROM person WHERE name = 'Irina'),
	(SELECT id FROM menu WHERE pizza_name = 'Sicilian pizza'),
	'2022-02-24');