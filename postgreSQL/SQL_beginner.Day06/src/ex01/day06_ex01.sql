--Создаю вью для удобства, который содержит id человека и пиццерии
CREATE VIEW pp_id AS
SELECT person_order.person_id, menu.pizzeria_id
FROM person_order
JOIN menu ON person_order.menu_id = menu.id;

--Создаю вью. Имеет айдишник, персон и пицца ид(сгруппированы), кол-во визитов
CREATE VIEW pp_id_disc AS
SELECT
  ROW_NUMBER() OVER (ORDER BY person_id, pizzeria_id) AS id,
  person_id,
  pizzeria_id,
  COUNT(*) AS discount
FROM
  pp_id
GROUP BY
  person_id, pizzeria_id
ORDER BY person_id, pizzeria_id;

--Все переношу в основную таблицу
INSERT INTO person_discounts (id, person_id, pizzeria_id, discount)
SELECT id, person_id, pizzeria_id, discount
FROM pp_id_disc;

--Меняю количество визитов на скидку
UPDATE person_discounts
SET discount = 
  CASE
    WHEN discount = 1 THEN 10.5
    WHEN discount = 2 THEN 22
    WHEN discount > 2 THEN 30
    ELSE discount
  END;