/* =========================================================================
   PERFORMANCE TEST — Airbnb Clone
   ======================================================================== */

/* ---------- 1. ORIGINAL (un-optimised) ---------------------------------- */
/*  Joins every row, returns * (wildcards), no early filtering              */
EXPLAIN ANALYZE
SELECT
    b.*,
    u.*,
    p.*,
    pay.*
FROM booking  b
JOIN app_user u  ON b.user_id     = u.user_id
JOIN property  p ON b.property_id = p.property_id
LEFT JOIN payment pay ON pay.booking_id = b.booking_id;


/* ---------- 2. REFACTORED (optimised) ----------------------------------- */
/*  –  Early filter to “confirmed” bookings (most common dashboard use-case) 
    –  Only SELECT the columns an API actually needs
    –  INNER JOIN to payment (confirmed ⇒ payment exists) 
    –  Makes indexes far more selective                                      */

WITH confirmed_bookings AS (
    SELECT booking_id, property_id, user_id,
           start_date, end_date
    FROM   booking
    WHERE  status = 'confirmed'             -- early filter uses idx_booking_status
)
EXPLAIN ANALYZE
SELECT
    cb.booking_id,
    cb.start_date,
    cb.end_date,
    u.first_name,
    u.last_name,
    p.name           AS property_name,
    p.location,
    pay.amount,
    pay.payment_method
FROM   confirmed_bookings cb
JOIN   app_user  u  ON u.user_id     = cb.user_id         -- idx_booking_user → PK
JOIN   property  p  ON p.property_id = cb.property_id     -- idx_booking_property → PK
JOIN   payment   pay ON pay.booking_id = cb.booking_id;   -- PK & unique FK

