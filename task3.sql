SELECT
  a.first_name,
  a.last_name,
  a.actor_id,
  MAX(f.release_year) - MIN(f.release_year) AS inactive_period
FROM
  actor a
  JOIN film_actor fa ON a.actor_id = fa.actor_id
  JOIN film f ON fa.film_id = f.film_id
GROUP BY
  a.actor_id
ORDER BY
  inactive_period 
  limit 1;