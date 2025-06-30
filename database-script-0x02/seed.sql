/* ===========================================================
   Airbnb-Clone • Sample Data Set
   (Compatible with the schema from the earlier CREATE script)
   =========================================================== */

/* ---------- USERS  ---------------------------------------- */
INSERT INTO app_user (
    user_id,          first_name, last_name,  email,
    password_hash,    phone_number, role
) VALUES
-- Host
('11111111-1111-1111-1111-111111111111', 'Hannah', 'Host',
 'host@example.com',  '$2b$12$u7uC9uW4x5eH/hosthash', '+1-212-555-0101', 'host'),
-- Guest
('22222222-2222-2222-2222-222222222222', 'Gary', 'Guest',
 'guest@example.com', '$2b$12$u7uC9uW4x5eH/guesthash', '+1-646-555-0202', 'guest'),
-- Admin
('33333333-3333-3333-3333-333333333333', 'Alice', 'Admin',
 'admin@example.com', '$2b$12$u7uC9uW4x5eH/adminhash', NULL,              'admin');


/* ---------- PROPERTIES  ----------------------------------- */
INSERT INTO property (
    property_id, host_id, name, description,
    location, price_per_night
) VALUES
('aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1', '11111111-1111-1111-1111-111111111111',
 'Cozy Loft in NYC',
 'Sunny loft apartment in SoHo, walking distance to major attractions.',
 'New York, NY', 120.00),

('aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2', '11111111-1111-1111-1111-111111111111',
 'Beachfront Bungalow',
 'Private bungalow with ocean view and direct beach access.',
 'Malibu, CA', 250.00);


/* ---------- BOOKINGS  ------------------------------------- */
INSERT INTO booking (
    booking_id,  property_id, user_id,
    start_date,  end_date,    status
) VALUES
-- Confirmed 4-night stay (Aug 1-5)
('bbbbbbb1-bbbb-bbbb-bbbb-bbbbbbbbbbb1',
 'aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1',
 '22222222-2222-2222-2222-222222222222',
 '2025-08-01', '2025-08-05', 'confirmed'),

-- Pending 2-night stay (Sep 10-12)
('bbbbbbb2-bbbb-bbbb-bbbb-bbbbbbbbbbb2',
 'aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2',
 '22222222-2222-2222-2222-222222222222',
 '2025-09-10', '2025-09-12', 'pending');


/* ---------- PAYMENTS  ------------------------------------- */
INSERT INTO payment (
    payment_id,  booking_id, amount,
    payment_date, payment_method
) VALUES
('ccccccc1-cccc-cccc-cccc-ccccccccccc1',
 'bbbbbbb1-bbbb-bbbb-bbbb-bbbbbbbbbbb1',
 480.00,        '2025-07-20 14:32:00', 'credit_card');


/* ---------- REVIEWS  -------------------------------------- */
INSERT INTO review (
    review_id,  property_id, user_id,
    rating, comment
) VALUES
('ddddddd1-dddd-dddd-dddd-ddddddddddd1',
 'aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1',
 '22222222-2222-2222-2222-222222222222',
 5, 'Amazing stay! Super clean, perfect location, and a very friendly host.');


/* ---------- MESSAGES  ------------------------------------- */
INSERT INTO message (
    message_id, sender_id, recipient_id,
    message_body, sent_at
) VALUES
('eeeeeee1-eeee-eeee-eeee-eeeeeeeeeee1',
 '22222222-2222-2222-2222-222222222222',   -- guest
 '11111111-1111-1111-1111-111111111111',   -- host
 'Hi Hannah, would early check-in around 11 AM be possible?', 
 '2025-07-15 09:10:00');

