# ��� Task 6 – Performance Monitoring & Refinement

PostgreSQL 16 -– 10 k-row seed

---

## 1️⃣  Choose a frequently-used query

Guest dashboard: *“Upcoming confirmed bookings for the next 30 days, with property & payment details.”*

```sql
SELECT b.booking_id,
       b.start_date,
       p.name AS property_name,
       pay.amount
FROM   booking      b
JOIN   property     p   ON p.property_id  = b.property_id
JOIN   payment      pay ON pay.booking_id = b.booking_id
WHERE  b.user_id = '22222222-2222-2222-2222-222222222222'
  AND  b.status  = 'confirmed'
  AND  b.start_date >= CURRENT_DATE
  AND  b.start_date  < CURRENT_DATE + INTERVAL '30 day';

