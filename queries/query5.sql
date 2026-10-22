-- ============================================================
-- Запрос 5
-- Для каждого заказчика посчитать число заказов и число изделий
-- (для 2D гистограммы).
-- ============================================================
SELECT
    c.client_id                  AS "id",
    c.surname                    AS "фамилия",
    c.name                       AS "имя",
    COUNT(DISTINCT o.order_id)   AS "заказов",
    COUNT(g.garment_id)          AS "изделий"
FROM client  c
JOIN "order" o ON o.client_id = c.client_id
JOIN garment g ON g.order_id  = o.order_id
GROUP BY c.client_id, c.surname, c.name
ORDER BY c.client_id;
