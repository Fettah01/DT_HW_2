SELECT s.staff_id, s.first_name, s.last_name, s.store_id, p.revenue
FROM (
    SELECT s.staff_id, s.store_id, SUM(p.amount) AS revenue
    FROM payment p
    JOIN staff s ON p.staff_id = s.staff_id
    WHERE EXTRACT(YEAR FROM p.payment_date) = 2017
    GROUP BY s.staff_id, s.store_id
) p
JOIN staff s USING (staff_id)
WHERE (p.store_id, p.revenue) IN (
    SELECT store_id, MAX(revenue) AS max_revenue
    FROM (
        SELECT s.staff_id, s.store_id, SUM(p.amount) AS revenue
        FROM payment p
        JOIN staff s ON p.staff_id = s.staff_id
        WHERE EXTRACT(YEAR FROM p.payment_date) = 2017
        GROUP BY s.staff_id, s.store_id
    ) sub
    GROUP BY store_id
)
ORDER BY s.store_id;