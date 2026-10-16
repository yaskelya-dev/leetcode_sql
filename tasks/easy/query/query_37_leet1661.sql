SELECT
    a1.machine_id,
    ROUND(SUM(a2.timestamp - a1.timestamp)::numeric / COUNT(*), 3) AS processing_time
FROM activity AS a1
LEFT JOIN activity AS a2
ON a1.machine_id = a2.machine_id AND
a1.process_id = a2.process_id AND
a1.activity_type != a2.activity_type AND
a1.activity_type = 'start'
WHERE a1.activity_type = 'start'
GROUP BY a1.machine_id