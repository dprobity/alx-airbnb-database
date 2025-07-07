-- 1. INNER JOIN: bookings with user details
SELECT b.*, u.first_name, u.last_name, u.email
FROM booking b
INNER JOIN app_user u ON b.user_id = u.user_id;

-- 2. LEFT JOIN: all properties and any associated reviews
SELECT p.*, r.rating, r.comment, r.created_at
FROM property p
LEFT JOIN review r ON p.property_id = r.property_id;

-- 3. FULL OUTER JOIN: all users and bookings (even if unrelated)
SELECT u.user_id, u.first_name, b.booking_id, b.start_date
FROM app_user u
FULL OUTER JOIN booking b ON u.user_id = b.user_id;

