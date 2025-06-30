Ì≥ê Normalization Review (‚Üí 3NF)

| Step                             | Check & Outcome                                                                                                                                                                                                                       |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **1 ‚Äî First Normal Form (1NF)**  | All tables already store atomic values (no repeating groups, arrays, or multi-valued columns).                                                                                                                                        |
| **2 ‚Äî Second Normal Form (2NF)** | Each table has a single-column primary key, so no partial-key dependencies exist.                                                                                                                                                     |
| **3 ‚Äî Third Normal Form (3NF)**  | Verified that **every non-key attribute is fully dependent on the primary key and not on another non-key attribute**. Most tables already meet this requirement; two minor adjustments were made to remove transitive / derived data. |

‚öôÔ∏è Adjustments Made to Reach 3NF

| Table       | Issue                                                                                                                                   | Normalized Fix                                                                                                                                                                                                                                                 |
| ----------- | --------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Booking** | `total_price` can be derived from `Property.price_per_night √ó number_of_nights`, so it violated 3NF (derived dependency on `Property`). | **Removed `total_price`.** A view or computed column can calculate price on-the-fly:<br>`CREATE VIEW booking_cost AS SELECT b.booking_id, (p.price_per_night * (b.end_date - b.start_date)) AS total_price FROM booking b JOIN property p USING(property_id);` |
| **User**    | Phone numbers may store country codes or formats inconsistently; not a strict 3NF breach but a potential anomaly.                       | No structural change (kept as a simple `String`). A separate `Phone` table could be introduced later if multiple numbers per user are required.                                                                                                                |


All other entities (Property, Payment, Review, Message) already satisfy 3NF:

Property ‚Äì attributes such as host_id, name, location, etc. depend directly on property_id.

Payment ‚Äì amount, payment_method, etc. depend on payment_id; 1-to-1 link via booking_id is enforced with a UNIQUE constraint.

Review ‚Äì rating, comment depend on review_id.

Message ‚Äì message metadata depends on message_id.

Denormalization Note:
We purposely kept price_per_night in Property for quick pricing queries.
Storing total_price in Booking would be an intentional denormalization for performance, but in strict 3NF it is removed or marked as a computed column.

Ì≥ä Result
After the above tweak, the schema contains no partial, transitive, or derived dependencies.
The design is now in Third Normal Form (3NF), minimizing redundancy and update anomalies while remaining practical for an Airbnb-style workload.
