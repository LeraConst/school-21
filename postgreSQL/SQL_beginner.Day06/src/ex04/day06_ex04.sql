-- 1
ALTER TABLE person_discounts
  ALTER COLUMN person_id SET NOT NULL,
  ADD CONSTRAINT ch_nn_person_id CHECK (person_id IS NOT NULL);

-- 2
ALTER TABLE person_discounts
  ALTER COLUMN pizzeria_id SET NOT NULL,
  ADD CONSTRAINT ch_nn_pizzeria_id CHECK (pizzeria_id IS NOT NULL);

-- 3
ALTER TABLE person_discounts
  ALTER COLUMN discount SET NOT NULL,
  ADD CONSTRAINT ch_nn_discount CHECK (discount IS NOT NULL);

-- 4
ALTER TABLE person_discounts
  ALTER COLUMN discount SET DEFAULT 0;

-- 5
ALTER TABLE person_discounts
  ADD CONSTRAINT ch_range_discount CHECK (discount >= 0 AND discount <= 100);
