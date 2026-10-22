-- ============================================================
-- Запрос 8
-- Для каждого ателье и каждого администратора посчитать число заказов
-- (для 3D гистограммы).
-- ============================================================
SELECT
    at.atelier_id     AS "ателье",
    ad.admin_id       AS "админ",
    ad.surname        AS "фамилия",
    COUNT(o.order_id) AS "заказов"
FROM atelier        at
CROSS JOIN administrator  ad
LEFT JOIN "order"   o  ON o.admin_id = ad.admin_id
WHERE ad.atelier_id = at.atelier_id
GROUP BY at.atelier_id, ad.admin_id, ad.surname
ORDER BY at.atelier_id, ad.admin_id;
