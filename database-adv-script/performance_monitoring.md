# Ì≥ù Database Performance Monitoring Report ‚Äì Airbnb Clone Backend

## ÌæØ Objective
Continuously monitor and refine **database performance** by analyzing query execution plans and making **schema adjustments** where necessary.

---

## Ì¥ç Monitoring Strategy

### **Tools Used:**
- `EXPLAIN ANALYZE` to review query execution plans and identify bottlenecks.
- Regularly tested **frequently used queries** such as:
  - Retrieving all bookings with user and property details
  - Fetching bookings within a specific date range
  - Ranking properties by total number of bookings

---

## ‚ö†Ô∏è Identified Bottlenecks

1. **Full Table Scans**
   - Observed in JOIN operations on columns without indexes.

2. **Slow Date Range Queries**
   - Queries on bookings by date range scanned the entire table without pruning.

3. **Unoptimized Aggregation Queries**
   - COUNT and RANK queries lacked supporting indexes for optimal performance.

---

## Ì¥ß Suggested Changes

| Issue                    | Suggested Change                           |
|---------------------------|---------------------------------------------|
| Full table scans on JOINs | Create indexes on frequently joined columns (`user_id`, `property_id`, `booking_id`). |
| Slow date range queries   | Implement **table partitioning** on bookings based on `start_date`. |
| Unoptimized aggregations | Add covering indexes for GROUP BY and ORDER BY queries. |

---

## Ìª†Ô∏è Implemented Changes

1. **Added Indexes**
   - `users(user_id)`
   - `users(email)`
   - `properties(property_id)`
   - `bookings(user_id)`
   - `bookings(property_id)`
   - `payments(booking_id)`

2. **Partitioned the Bookings Table**
   - Used **RANGE partitioning** on `start_date` to improve date-filtered query performance.

3. **Query Refactoring**
   - Replaced `SELECT *` with **explicit column selection** to reduce data load.
   - Replaced unnecessary INNER JOINs with LEFT JOINs where applicable.

---

## ‚ö° Results & Improvements

| Metric                        | Before Changes | After Changes  |
|--------------------------------|----------------|----------------|
| Execution time for date range booking query | High (full table scan) | Significantly reduced due to partition pruning |
| JOIN queries performance | Slow due to full scans | Faster with appropriate indexes |
| Aggregation queries | Moderate | Optimized with supporting indexes |

---

## ‚úÖ Conclusion

Continuous monitoring using **EXPLAIN ANALYZE** and implementing targeted schema adjustments (indexes, partitioning, and query refactoring) greatly enhances database performance and scalability for production-level systems such as an Airbnb clone backend.

---
