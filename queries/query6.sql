-- ============================================================
-- Запрос 6
-- Найти типы фурнитуры, которые использовались чаще, чем фурнитура А.
-- ============================================================
SELECT
    a.type                      AS "тип фурнитуры",
    COUNT(ag.garment_id)        AS "использований"
FROM accessories a
JOIN accessories_garment ag ON ag.accessory_id = a.accessory_id
GROUP BY a.type
HAVING COUNT(ag.garment_id) > (
    SELECT COUNT(*)
    FROM accessories_garment
    WHERE accessory_id = 296
)
ORDER BY "использований" DESC;
