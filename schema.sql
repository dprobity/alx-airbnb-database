/* ===========================================================
   Airbnb-Clone 3NF Schema  (PostgreSQL 16+ dialect)
   -----------------------------------------------------------
   1. Tables & constraints
   2. Indexes for high-traffic look-ups / joins
   ===========================================================
*/

/* ---------- 1.  ENUM helpers  ---------- */
CREATE TYPE role_enum          AS ENUM ('guest','host','admin');
CREATE TYPE booking_status_enum AS ENUM ('pending','confirmed','canceled');
CREATE TYPE pay_method_enum     AS ENUM ('credit_card','paypal','stripe');

/* ---------- 2.  Core tables  ---------- */

/* --- USER -------------------------------------------------- */
CREATE TABLE app_user (
    user_id        UUID PRIMARY KEY,
    first_name     VARCHAR(100) NOT NULL,
    last_name      VARCHAR(100) NOT NULL,
    email          VARCHAR(255) NOT NULL UNIQUE,
    password_hash  VARCHAR(255) NOT NULL,
    phone_number   VARCHAR(20),
    role           role_enum     NOT NULL,
    created_at     TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP
);

/* --- PROPERTY ---------------------------------------------- */
CREATE TABLE property (
    property_id      UUID PRIMARY KEY,
    host_id          UUID NOT NULL
                       REFERENCES app_user(user_id) ON DELETE CASCADE,
    name             VARCHAR(255) NOT NULL,
    description      TEXT         NOT NULL,
    location         VARCHAR(255) NOT NULL,
    price_per_night  NUMERIC(10,2) NOT NULL CHECK (price_per_night > 0),
    created_at       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP
);

/* --- BOOKING  (3NF: no stored total_price) ----------------- */
CREATE TABLE booking (
    booking_id   UUID PRIMARY KEY,
    property_id  UUID NOT NULL
                     REFERENCES property(property_id) ON DELETE CASCADE,
    user_id      UUID NOT NULL
                     REFERENCES app_user(user_id)   ON DELETE CASCADE,
    start_date   DATE NOT NULL,
    end_date     DATE NOT NULL CHECK (end_date > start_date),
    status       booking_status_enum NOT NULL,
    created_at   TIMESTAMP           NOT NULL DEFAULT CURRENT_TIMESTAMP
);

/* VIEW: derive total_price at query time (3NF-friendly) */
CREATE VIEW booking_price AS
SELECT b.*,
       (p.price_per_night * (end_date - start_date)) AS total_price
FROM   booking b
JOIN   property p USING (property_id);

/* --- PAYMENT  (1-to-1 with booking) ------------------------ */
CREATE TABLE payment (
    payment_id     UUID PRIMARY KEY,
    booking_id     UUID NOT NULL UNIQUE
                     REFERENCES booking(booking_id) ON DELETE CASCADE,
    amount         NUMERIC(10,2) NOT NULL CHECK (amount > 0),
    payment_date   TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    payment_method pay_method_enum NOT NULL
);

/* --- REVIEW ----------------------------------------------- */
CREATE TABLE review (
    review_id    UUID PRIMARY KEY,
    property_id  UUID NOT NULL
                     REFERENCES property(property_id) ON DELETE CASCADE,
    user_id      UUID NOT NULL
                     REFERENCES app_user(user_id)   ON DELETE CASCADE,
    rating       INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment      TEXT    NOT NULL,
    created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

/* --- MESSAGE  (user↔user chat) ----------------------------- */
CREATE TABLE message (
    message_id    UUID PRIMARY KEY,
    sender_id     UUID NOT NULL
                     REFERENCES app_user(user_id) ON DELETE CASCADE,
    recipient_id  UUID NOT NULL
                     REFERENCES app_user(user_id) ON DELETE CASCADE,
    message_body  TEXT NOT NULL,
    sent_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

/* ---------- 3.  Indexes for performance  ---------- */

/* USER */
CREATE INDEX idx_user_email ON app_user(email);

/* PROPERTY */
CREATE INDEX idx_property_host      ON property(host_id);
CREATE INDEX idx_property_location  ON property(location);

/* BOOKING */
CREATE INDEX idx_booking_property   ON booking(property_id);
CREATE INDEX idx_booking_user       ON booking(user_id);
CREATE INDEX idx_booking_availability
            ON booking(property_id, start_date, end_date);

/* PAYMENT */
-- unique constraint on booking_id already creates an index

/* REVIEW */
CREATE INDEX idx_review_property ON review(property_id);
CREATE INDEX idx_review_user     ON review(user_id);

/* MESSAGE */
CREATE INDEX idx_message_sender    ON message(sender_id);
CREATE INDEX idx_message_recipient ON message(recipient_id);

