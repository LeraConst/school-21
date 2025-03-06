insert into currency values (100, 'EUR', 0.85, '2022-01-01 13:29');
insert into currency values (100, 'EUR', 0.79, '2022-01-08 13:29');

SELECT coalesce(u.name, 'not defined')     AS name,
       coalesce(u.lastname, 'not defined') AS lastname,
       c.name                              AS currency_name,
       b.money * c.rate_to_usd             AS currency_in_usd
FROM balance b
    LEFT JOIN "user" u ON b.user_id = u.id
    INNER JOIN currency c
        ON (b.currency_id = c.id
               AND c.updated = coalesce(
                   (SELECT max(currency.updated)
                    FROM currency
                    WHERE c.id = currency.id
                      AND b.updated >= currency.updated
                    GROUP BY currency.id),
                   (SELECT min(currency.updated)
                    FROM currency
                    WHERE c.id = currency.id
                      AND b.updated < currency.updated
                    GROUP BY currency.id)))
ORDER BY name DESC, lastname, currency_name;