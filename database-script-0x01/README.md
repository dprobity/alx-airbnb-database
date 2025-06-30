| Table / Type                                    | Purpose                                                                                                                                     |
| ----------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| **roles** ( `role_enum` )                       | Predefined user roles — **guest**, **host**, **admin**. Used by the `users.role` column to drive permission checks across the platform.     |
| **payment\_methods** ( `pay_method_enum` )      | Valid payment options — **credit\_card**, **paypal**, **stripe**. Keeps transactions consistent and prevents invalid methods.               |
| **booking\_statuses** ( `booking_status_enum` ) | Life-cycle states for reservations — **pending**, **confirmed**, **canceled**. Lets the app track and filter bookings by progress.          |
| **users** ( `app_user` )                        | Central profile table storing names, e-mail, hashed password, phone, role, and join date. Every actor (guest, host, admin) lives here.      |
| **properties**                                  | Listings created by hosts. Holds title, description, location, nightly price, timestamps, and a `host_id` FK back to **users**.             |
| **bookings**                                    | Reservations linking a guest (`user_id`) to a listing (`property_id`) with start/end dates and status. `total_price` is derived via a view. |
| **payments**                                    | One-to-one with **bookings**. Records amount, payment method, timestamp, and enforces a UNIQUE FK on `booking_id` for integrity.            |
| **messages**                                    | Direct chats between users (e.g., guest↔host). Stores sender, recipient, body, and send time to keep all trip communication on-platform.    |
| **reviews**                                     | User feedback for properties. Captures 1-to-5 star ratings, comments, and timestamps, linked to both the reviewer and the listing.          |


��� Notes & Rationale

| Topic                 | Design choice                                                                                                                                     |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| **3NF compliance**    | `total_price` removed from `booking`; derived in `booking_price` view. All remaining attributes depend solely on their table’s PK.                |
| **ENUM types**        | PostgreSQL native `CREATE TYPE … AS ENUM` gives validation without extra tables.                                                                  |
| **Cascading deletes** | `ON DELETE CASCADE` on FKs cleans up child rows automatically when a user, property, or booking is removed.                                       |
| **Indexes**           | Added on unique look-ups (`email`), FK columns used in joins, and composite `(property_id, start_date, end_date)` to speed availability searches. |
| **Check constraints** | Ensure positive pricing, valid rating range, and logical date ranges.                                                                             |

