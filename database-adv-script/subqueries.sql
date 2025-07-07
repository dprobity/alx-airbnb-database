-- 1. Non-correlated subquery: properties with avg rating > 4.0
SELECT property_id, name
FROM property
WHERE property_id IN (
    SELECT property_id
    FROM review
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
);

-- 2. Correlated subquery: users with more than 3 bookings
SELECT u.user_id, u.first_name, u.email
FROM app_user u
WHERE (
    SELECT COUNT(*) FROM booking b WHERE b.user_id = u.user_id
) > 3;

