-- ============================================================
-- Запрос 2
-- Для ателье А рассчитать число изделий, пошитых портным Б.
-- ============================================================
SELECT
    t.atelier_id        AS "ателье",
    t.tailor_id         AS "портной",
    t.surname           AS "фамилия",
    COUNT(g.garment_id) AS "число изделий"
FROM tailor  t
JOIN garment g ON g.tailor_id = t.tailor_id
WHERE t.atelier_id = 2
  AND t.tailor_id  = 22
GROUP BY t.atelier_id, t.tailor_id, t.surname;
