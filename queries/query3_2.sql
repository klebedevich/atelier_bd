-- ============================================================
-- Запрос 3.2
-- Найти заказчика, заказавшего минимальное количество фурнитуры
-- (по всем ателье).
-- ============================================================
SELECT
    c.client_id     AS "id заказчика",
    c.surname       AS "фамилия",
    c.name          AS "имя",
    c.patronymic    AS "отчество",
    SUM(acc.quantity_used) AS "количество фурнитуры"
FROM client      c
JOIN "order"     o  ON o.client_id    = c.client_id
JOIN garment     g  ON g.order_id     = o.order_id
JOIN accessories_garment ag ON ag.garment_id = g.garment_id
JOIN accessories acc ON acc.accessory_id = ag.accessory_id
GROUP BY c.client_id, c.surname, c.name, c.patronymic
HAVING SUM(acc.quantity_used) = (
    SELECT MIN(t.total)
    FROM (
        SELECT SUM(acc2.quantity_used) AS total
        FROM "order"     o2
        JOIN garment     g2  ON g2.order_id     = o2.order_id
        JOIN accessories_garment ag2 ON ag2.garment_id = g2.garment_id
        JOIN accessories acc2 ON acc2.accessory_id = ag2.accessory_id
        GROUP BY o2.client_id
    ) t
)
ORDER BY c.client_id;
