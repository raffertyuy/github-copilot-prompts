WITH customer_category_counts AS (
    SELECT
        r.customer_id,
        cat.name AS category_name,
        COUNT(*) AS rental_count,
        ROW_NUMBER() OVER (
            PARTITION BY r.customer_id
            ORDER BY COUNT(*) DESC, cat.name
        ) AS rn
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category cat ON fc.category_id = cat.category_id
    GROUP BY r.customer_id, cat.name
),
customer_total_rentals AS (
    SELECT r.customer_id, COUNT(*) AS total_rentals
    FROM rental r
    GROUP BY r.customer_id
)
SELECT
    c.first_name,
    c.last_name,
    ci.city,
    co.country,
    COALESCE(tr.total_rentals, 0) AS total_rentals,
    ccc.category_name AS top_film_category,
    COALESCE(ccc.rental_count, 0) AS top_film_category_count
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
LEFT JOIN customer_total_rentals tr ON c.customer_id = tr.customer_id
LEFT JOIN customer_category_counts ccc ON c.customer_id = ccc.customer_id AND ccc.rn = 1;