SELECT w2.id
FROM weather AS w1
LEFT JOIN weather AS w2
ON w1.recordDate = w2.recordDate - INTERVAL '1 day'
WHERE w2.temperature > w1.temperature