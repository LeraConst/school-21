CREATE VIEW v_price_with_discount AS
WITH step_one AS
	(SELECT person.name, menu.pizza_name, menu.price, ROUND(menu.price - menu.price * 0.1) AS discount_price
	FROM person_order
	JOIN person ON person_order.person_id = person.id
	JOIN menu ON person_order.menu_id = menu.id
	ORDER BY name, pizza_name)
SELECT *
FROM step_one;