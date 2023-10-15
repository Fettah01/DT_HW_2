WITH Top5RentedMovies AS (
  SELECT
    f.film_id,
    f.title,
    COUNT(p.payment_id) AS rental_count
  FROM
    film f
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    JOIN payment p ON r.rental_id = p.rental_id
  GROUP BY
    f.film_id, f.title
  ORDER BY
    rental_count DESC
  LIMIT 5
)

SELECT
  trm.film_id,
  trm.title AS movie_title,
  CASE
    WHEN f.rating = 'PG-13' THEN '13+'
    WHEN f.rating = 'NC-17' THEN '18+'
    WHEN f.rating = 'R' THEN '17+'
    WHEN f.rating = 'PG' THEN '7+'
    WHEN f.rating = 'G' THEN 'All ages'
    ELSE 'Not specified'
  END AS appropriate_age_rating
FROM
  Top5RentedMovies trm
  JOIN film f ON trm.film_id = f.film_id
ORDER BY
  trm.film_id;