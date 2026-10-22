-- ============================================================
-- Запрос 4
-- Посчитать число заказчиков с одинаковым числом изделий в заказах
-- (для 2D гистограммы).
-- ============================================================
SELECT
    t.garments_per_client  AS "число изделий",
    COUNT(*)               AS "число заказчиков"
FROM (
    SELECT
        o.client_id,
        COUNT(g.garment_id) AS garments_per_client
    FROM "order" o
    JOIN garment g ON g.order_id = o.order_id
    GROUP BY o.client_id
) AS t
GROUP BY t.garments_per_client
ORDER BY t.garments_per_client;
