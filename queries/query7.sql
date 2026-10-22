-- ============================================================
-- Запрос 7
-- Найти заказчиков, которые никогда не использовали ткань А.
-- ============================================================
SELECT
    c.client_id   AS "id",
    c.surname     AS "фамилия",
    c.name        AS "имя",
    c.patronymic  AS "отчество"
FROM client          c
LEFT JOIN "order"    o  ON o.client_id  = c.client_id
LEFT JOIN garment    g  ON g.order_id   = o.order_id
LEFT JOIN fabric_garment fg
       ON fg.garment_id = g.garment_id
      AND fg.fabric_id  = 495
GROUP BY c.client_id, c.surname, c.name, c.patronymic
HAVING COUNT(fg.fabric_id) = 0
ORDER BY c.surname, c.name;
