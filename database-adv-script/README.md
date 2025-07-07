# � ALX Airbnb Clone – Advanced SQL Tasks (Qwerying and Joins)

This project expands the Airbnb database schema into real-world performance, query optimization, and analytical use cases. It demonstrates deep SQL proficiency through join queries, subqueries, window functions, indexing, and performance tuning.

---

## � Directory: `database-adv-script`

---

## ✅ Task 0: Write Complex Queries with Joins

### Goals:
- Practice different JOIN types to combine data across tables.

### Key Queries:
- `INNER JOIN`: Bookings with user details  
- `LEFT JOIN`: Properties with or without reviews  
- `FULL OUTER JOIN`: All users and all bookings, even unmatched

� **File**: `joins_queries.sql`

---

## ✅ Task 1: Practice Subqueries

### Goals:
- Use subqueries to perform filtered or nested lookups

### Key Queries:
- Properties with average rating > 4.0 (non-correlated)
- Users with more than 3 bookings (correlated)

� **File**: `subqueries.sql`

---

## ✅ Task 2: Aggregations and Window Functions

### Goals:
- Perform analytics using `GROUP BY` and window functions

### Key Queries:
- Total number of bookings per user using `COUNT` and `GROUP BY`
- Rank properties by booking count using `RANK() OVER (...)`

� **File**: `aggregations_and_window_functions.sql`

---

## ✅ Task 3: Implement Indexes for Optimization

### Goals:
- Create indexes on high-usage columns to improve performance
- Measure query execution plans before/after indexing

� **Files**:
- `database_index.sql`: `CREATE INDEX` commands for user email, booking FKs, property location
- `index_performance.md`: Report on query improvement using `EXPLAIN ANALYZE`

---

## ✅ Task 4: Optimize Complex Queries

### Goals:
- Refactor multi-join queries for performance
- Identify slow joins or redundant paths

### Key Actions:
- Analyzed original query with `EXPLAIN`
- Removed unnecessary joins, ensured indexes were used

� **Files**:
- `perfomance.sql`: Initial + optimized queries
- `optimization_report.md`: Summary of improvements

---

## ✅ Task 5: Partitioning Large Tables

### Goals:
- Improve scalability of large `booking` table using partitioning

### Key Actions:
- Partitioned `booking` table by `start_date`
- Created 2024 and 2025 partitions
- Measured performance improvement using date-range filters

� **Files**:
- `partitioning.sql`: Partition setup
- `partition_performance.md`: Impact analysis

---

## ✅ Task 6: Monitor and Refine Performance

### Goals:
- Use query execution plans to identify bottlenecks
- Recommend schema or index changes

### Key Actions:
- Monitored `booking` join performance using `EXPLAIN ANALYZE`
- Added missing indexes to reduce full table scans
- Suggested composite indexes and schema adjustments

� **File**: `performance_monitoring.md`

---

## � Overall Outcome

This project demonstrates how a normalized Airbnb-style schema can scale using:
- Logical views (like `booking_price`) instead of redundant columns
- Proper indexing on `JOIN`/`WHERE` keys
- Partitioning and materialized views for heavy reads
- Query refactoring to reduce execution time
- Full-cycle monitoring using PostgreSQL tools

� The system is now optimized for both data integrity and performance — ready for production or advanced analytics workloads.

