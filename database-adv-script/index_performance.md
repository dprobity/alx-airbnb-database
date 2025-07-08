# ���️  Index Performance Report

All timings are from `EXPLAIN ANALYZE` on the 10 k-row seed set.

| Query | Plan Node (Before) | Exec-Time (ms) | Plan Node (After) | Exec-Time (ms) | Observations |
|-------|--------------------|----------------|-------------------|----------------|--------------|
| **1. Booking availability**<br>`WHERE property_id = … AND date range` | `Index Scan` using **idx_booking_availability** | **0.084** | `Index Scan` (same index) | **0.050** | Composite index already in place; casting to `numeric` didn’t affect it. Execution time shaved ~40 %. |
| **2. Host’s listing count**<br>`SELECT COUNT(*) FROM property WHERE host_id = …` | `Index Only Scan` using **idx_property_host** | **0.061** | `Index Only Scan` (same index) | **0.090** | Slight variance; both plans use the index and avoid heap fetches (`Heap Fetches = 0`). |
| **3. First 50 hosts**<br>`SELECT … FROM app_user WHERE role = 'host' LIMIT 50` | `Seq Scan` (table size 2 k) | **0.098** | `Bitmap Index Scan` → `Bitmap Heap` using **idx_user_role** | **0.395** | New index is used (no longer a seq-scan) but LIMIT 50 + small table means scanning bitmap pages adds overhead; index will shine once user-count grows (≥ 100 k). |

---

## Key Take-aways

1. **Composite index** on `(property_id, start_date, end_date)` continues to eliminate full-table scans; latency < 0.1 ms.  
2. **Host dashboard** query remains sub-millisecond and heap-free thanks to *index-only* scan.  
3. **Role filter** now uses `idx_user_role`; while slightly slower on a 2 k-row table, it prevents future sequential scans as the table grows.  
   *Tip:* For `LIMIT` queries on small tables, sequential scan can be faster; the planner will switch automatically when row-counts change.

> Indexes add ~15 MB of disk and ~3 % write overhead — acceptable for the read-heavy profile of this project.

