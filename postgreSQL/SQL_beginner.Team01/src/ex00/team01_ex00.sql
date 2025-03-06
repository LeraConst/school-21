WITH b AS (
    SELECT user_id, type, currency_id, sum(money) AS volume
    FROM balance
    GROUP BY user_id, type, currency_id)

SELECT coalesce(u.name, 'not defined')     AS name,
       coalesce(u.lastname, 'not defined') AS lastname,
       b.type                              AS type,
       volume,
       coalesce(c.name, 'not defined')     AS currency_name,
       coalesce(c.rate_to_usd, 1)          AS last_rate_to_usd,
       volume * coalesce(c.rate_to_usd, 1) AS total_volume_in_usd
FROM b
    LEFT JOIN "user" u ON b.user_id = u.id
    LEFT JOIN currency c
       ON (b.currency_id = c.id
               AND c.updated = (SELECT max(currency.updated)
                                FROM currency
                                WHERE  c.id = currency.id
                                GROUP BY currency.id))
ORDER BY name DESC, lastname, type;