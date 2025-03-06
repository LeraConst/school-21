WITH my_menu AS 
	(SELECT pizza_name, pizzeria_id, price
	FROM menu
	WHERE pizza_name IN ('mushroom pizza', 'pepperoni pizza'))
SELECT my_menu.pizza_name, pizzeria.name AS pizzeria_name, my_menu.price
FROM my_menu
JOIN pizzeria ON pizzeria.id = my_menu.pizzeria_id
ORDER BY my_menu.pizza_name, pizzeria_name;