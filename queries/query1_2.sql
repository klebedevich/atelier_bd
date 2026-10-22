-- ============================================================
-- Запрос 1.2
-- Найти администраторов, работающих в ателье А, выполняющих заказ
-- для заказчика Б, в котором используется фурнитура В и ткань Г
-- не менее двух раз.
-- ============================================================
SELECT
    a.admin_id    AS "id",
    a.surname     AS "фамилия",
    a.name        AS "имя",
    a.patronymic  AS "отчество",
    COUNT(*)      AS "совпадений"
FROM administrator   a
JOIN "order"         o   ON o.admin_id      = a.admin_id
JOIN garment         g   ON g.order_id      = o.order_id
JOIN fabric_garment  fg  ON fg.garment_id   = g.garment_id
JOIN fabric          f   ON f.fabric_id     = fg.fabric_id
JOIN accessories_garment ag  ON ag.garment_id   = g.garment_id
JOIN accessories     acc ON acc.accessory_id = ag.accessory_id
WHERE a.atelier_id = 1
  AND o.client_id  = 212
  AND f.article    = 'TKN-00136'
  AND acc.article  = 'ACC-00215'
GROUP BY a.admin_id, a.surname, a.name, a.patronymic
HAVING COUNT(*) >= 2
ORDER BY a.surname, a.name;
