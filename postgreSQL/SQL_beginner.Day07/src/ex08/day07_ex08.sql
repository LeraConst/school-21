WITH step_visits AS (
	SELECT person.address, pizzeria.name, COUNT(person_visits.id) AS count_of_visits
	FROM person_visits
	JOIN person ON person_visits.person_id = person.id
	JOIN pizzeria ON person_visits.pizzeria_id = pizzeria.id
	GROUP BY person.address, pizzeria.name
	),
	step_orders AS (
	SELECT person.address, pizzeria.name, COUNT(person_order.id) AS count_of_visits
	FROM person_order
	JOIN person ON person_order.person_id = person.id
	JOIN menu ON person_order.menu_id = menu.id
	JOIN pizzeria ON menu.pizzeria_id = pizzeria.id
	GROUP BY person.address, pizzeria.name
	)
SELECT *
FROM step_orders
ORDER BY address, name;

--Мне показалась странной формулировка данного задания, "изначально пишет, что посещает", потом уже работаем с ордерами... Оставлю здесь step_vists, но по факту он не используется