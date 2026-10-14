SELECT
    MIN(u.name) AS name,
    CASE
        WHEN SUM(r.distance) IS NULL THEN 0
        ELSE  SUM(r.distance)
    END AS travelled_distance
FROM users AS u
LEFT JOIN rides AS r
ON u.id = r.user_id
GROUP BY u.id
ORDER BY travelled_distance DESC, name
