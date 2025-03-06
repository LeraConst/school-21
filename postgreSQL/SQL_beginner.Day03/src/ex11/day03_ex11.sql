UPDATE menu
SET price = (SELECT ROUND(price * 0.9) FROM menu WHERE pizza_name = 'greek pizza')
WHERE pizza_name = 'greek pizza'