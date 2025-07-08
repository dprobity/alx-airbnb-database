-- 1. Count of bookings per user
SELECT u.user_id, u.first_name, COUNT(b.booking_id) AS total_bookings
FROM app_user u
LEFT JOIN booking b ON u.user_id = b.user_id
GROUP BY u.user_id;

-- 2. Rank properties by booking count
SELECT p.property_id, p.name,
       COUNT(b.booking_id) AS booking_count,
       RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS rank
FROM property p
LEFT JOIN booking b ON p.property_id = b.property_id
GROUP BY p.property_id;

