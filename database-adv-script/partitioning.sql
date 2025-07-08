/* =========================================================
   Partition booking by year(start_date)
   =========================================================
   Steps
   -----
   1. Create NEW parent table booking_part
   2. Create yearly partitions 2023-2028 (+ default future)
   3. Copy data from legacy booking
   4. Create same indexes & constraints on each partition
   5. (optional) swap names so app keeps using “booking”
   ========================================================= */

BEGIN;

------------------------------------------------------------
-- 1. Parent partitioned table (same columns as booking)
------------------------------------------------------------
CREATE TABLE booking_part (
    booking_id   UUID PRIMARY KEY,
    property_id  UUID NOT NULL REFERENCES property(property_id) ON DELETE CASCADE,
    user_id      UUID NOT NULL REFERENCES app_user(user_id)     ON DELETE CASCADE,
    start_date   DATE NOT NULL,
    end_date     DATE NOT NULL CHECK (end_date > start_date),
    status       booking_status_enum NOT NULL,
    created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (start_date);

------------------------------------------------------------
-- 2. Yearly partitions (extend as needed)
------------------------------------------------------------
DO $$
DECLARE yr INT := 2023;
BEGIN
  WHILE yr <= 2028 LOOP
    EXECUTE format (
      'CREATE TABLE booking_%s PARTITION OF booking_part
         FOR VALUES FROM (%L) TO (%L);',
      yr, yr || '-01-01', (yr + 1) || '-01-01'
    );
    yr := yr + 1;
  END LOOP;
END $$;

-- Default catch-all for future dates
CREATE TABLE booking_future PARTITION OF booking_part
    DEFAULT;

------------------------------------------------------------
-- 3. Move data from old table
------------------------------------------------------------
INSERT INTO booking_part
SELECT * FROM booking;

-- Verify counts match
-- SELECT COUNT(*) FROM booking;
-- SELECT COUNT(*) FROM booking_part;

------------------------------------------------------------
-- 4. Indexes on partitions inherit from parent if declared here
------------------------------------------------------------
CREATE INDEX idx_booking_part_property
    ON booking_part(property_id);

CREATE INDEX idx_booking_part_user
    ON booking_part(user_id);

CREATE INDEX idx_booking_part_status
    ON booking_part(status);

CREATE INDEX idx_booking_part_avail
    ON booking_part(property_id, start_date, end_date);

------------------------------------------------------------
-- 5. Optionally swap names so application code is unchanged
------------------------------------------------------------
-- ALTER TABLE booking RENAME TO booking_legacy;
-- ALTER TABLE booking_part RENAME TO booking;
COMMIT;

