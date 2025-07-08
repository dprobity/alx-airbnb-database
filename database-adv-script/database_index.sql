/* =========   NEW INDEXES FOR PERFORMANCE   ========= */

/* --- app_user ------------------------------------- */
CREATE INDEX IF NOT EXISTS idx_user_role
    ON app_user(role);

/* --- property ------------------------------------- */
CREATE INDEX IF NOT EXISTS idx_property_host
    ON property(host_id);

CREATE INDEX IF NOT EXISTS idx_property_location
    ON property(location);

/* Optional compound: host’s listings in a given city */
-- CREATE INDEX IF NOT EXISTS idx_property_host_location
--     ON property(host_id, location);

/* --- booking -------------------------------------- */
CREATE INDEX IF NOT EXISTS idx_booking_user
    ON booking(user_id);

CREATE INDEX IF NOT EXISTS idx_booking_property
    ON booking(property_id);

CREATE INDEX IF NOT EXISTS idx_booking_status
    ON booking(status);

/* Composite index for availability look-ups */
CREATE INDEX IF NOT EXISTS idx_booking_availability
    ON booking(property_id, start_date, end_date);



/* Booking availability query (uses idx_booking_availability) */
EXPLAIN ANALYZE
SELECT *
FROM booking
WHERE property_id = 'aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1'
  AND start_date <= '2025-08-01'
  AND end_date   >= '2025-08-05';

/* Host listings count (uses idx_property_host) */
EXPLAIN ANALYZE
SELECT COUNT(*)
FROM property
WHERE host_id = '11111111-1111-1111-1111-111111111111';
