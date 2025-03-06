-- Комментарии к таблице
COMMENT ON TABLE person_discounts IS 'Table for storing information about discounts provided to different individuals in various pizzerias.';

-- Комментарии к столбцам
COMMENT ON COLUMN person_discounts.person_id IS 'Identifier of the person for whom the discount is provided.';
COMMENT ON COLUMN person_discounts.pizzeria_id IS 'Identifier of the pizzeria where the discount is applied.';
COMMENT ON COLUMN person_discounts.discount IS 'Discount amount in percentage.';