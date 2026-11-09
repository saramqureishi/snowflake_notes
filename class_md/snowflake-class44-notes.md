# Class 44 — Cost Control: Resource Monitors, Cost Types & Zero-Copy Cloning

**Snowflake — Class 44 Notes**
*Sara — SnowPro Core preparation*

> ⭐⭐ **Strong, exam-relevant class.** Two big SnowPro Core topics taught with hands-on: **Resource Monitors** and **Zero-Copy Cloning**, plus the **cost model** (compute vs storage vs cloud services/stage) and a **warehouse-vs-database** privileges recap. Learn all of it.
>
> **Honest labelling:**
> - **§1** (job-market intro) is **career, not exam** — he showed Snowflake JD/role postings to motivate; skim it.
> - **§2–§7** are the exam content.
> - He **still didn't do the clustering performance demo** (promised since Class 42). He again said **"tomorrow"** he'll cover **what happens to micro-partitions on INSERT/UPDATE/DELETE**, then clustering / SOS / QAS. So that's the next-class plan.
>
> **Things he said that matter to you (flagged as you asked):**
> - 📚 **The Drive folder is confirmed as `Interview_Preparation`** — he said it "will have all the certification details." (This matches the folder he gave you on 2 Nov.) The last ~5 min of class were him fixing which batch folder it was uploaded to; it's now there.
> - 💼 He showed live **Snowflake job postings** (HCL, DTCC, Cognizant, "saffron digital", etc.) — recurring message: **"if you're good at Snowflake and dbt, you can easily get a job."** Good CV motivation.

---

## 1. Job-market intro (career, NOT exam)

- He opened by showing real **job descriptions**: the common stack employers want is **Snowflake + dbt + Airflow + SQL + AWS** — which is exactly your CV section. Senior roles wanted 5+ yrs Snowflake.
- Listed recent Snowflake openings (late Oct): **HCL**, **DTCC**, **Cognizant**, **saffron digital**, etc. — "Snowflake developer / data engineer".
- Takeaway: Snowflake + dbt is in demand; he offered CV help. **Not SnowPro Core content.**

## 2. Resource Monitors ⭐⭐ (exam + asked in interviews)

A **resource monitor (RM)** caps **credit consumption** and fires **alerts/actions** at thresholds — a **cost-control / admin** feature. He said it's come up in interviews ("do you have an idea on RM?").

- **Where:** Snowsight → **Admin → Cost Management → Resource Monitors → + Resource Monitor**. Or SQL (`CREATE RESOURCE MONITOR`).
- **Set:** a **credit quota** (credits allowed per cycle) + a **schedule** (Starts: immediately; **Resets: monthly** / weekly / etc.).
- ⭐⭐ **Monitoring level — two choices (exam-important):**
  - **ACCOUNT level** → monitors **all warehouses** in the account (one account-wide budget). *Only one account-level RM can be active.*
  - **WAREHOUSE level** → monitors a **specific individual warehouse** (you attach the RM to that warehouse).
- ⭐⭐ **Threshold actions ("Notify when % of credits used"):**
  - **Notify** — just emails an alert (e.g. at 50%, 80%).
  - **Suspend** (at e.g. 100%) — stops the warehouse **but lets running queries finish** first.
  - **Suspend Immediately** — **aborts running queries** and suspends at once.
  - His memory hook: *80% → wait for the job to finish, then suspend; 90%/100% → kill running jobs immediately.*
- Verify:
  ```sql
  SHOW RESOURCE MONITORS;        -- lists RMs, their level, quota, triggers
  SHOW WAREHOUSES;               -- the RESOURCE_MONITOR column: null = unmonitored, else the RM name
  ```
- **Who it's for:** admins/billing teams planning budget — "this is for admins, not developers." But when alerts fire, **developers help investigate** which **top-consuming queries / long-running jobs** drove the cost, then tune them (see §7 next class).
- Note (your trial): it shows ~$398 of $400 trial credits left; RM thresholds in the demo were framed as dollars for simplicity, but RMs really count **credits**.

## 3. Snowflake cost types ⭐

Three cost buckets he pointed to in **Cost Management → consumption**:

| Cost type | Driven by | Notes |
|---|---|---|
| **Compute** | **Warehouses** (virtual warehouse credits) | Charged per-second while a warehouse runs; the demo showed 0.1–0.3 credits per WH |
| **Storage** | **Databases** (the data you store) | Flat per-TB; this is where cloning savings land |
| **Cloud services / stage** | internal + external **stages** | ⭐ Worksheets are auto-saved to the **internal stage** (you never save them explicitly) — that's a small stage cost |

- ⭐ Key exam point: **compute and storage are billed separately**, and **warehouse (compute) ≠ database (storage)** — different objects, different costs.

## 4. Warehouse vs Database are different objects — with different privileges ⭐

He proved this by creating a role and granting step-by-step:
```sql
-- a role with no privileges cannot create a database
GRANT CREATE DATABASE ON ACCOUNT TO ROLE dev_role;   -- now it can
-- once you own/USE a database you can create its child objects (schema, table) freely
-- BUT creating a WAREHOUSE needs a SEPARATE privilege:
GRANT CREATE WAREHOUSE ON ACCOUNT TO ROLE dev_role;
```
- ⭐ **Exam point:** having database access does **not** give warehouse-creation rights. **`CREATE DATABASE` and `CREATE WAREHOUSE` are distinct account-level privileges.** Once you have a database, though, you inherit the ability to create its underlying objects (schemas, tables).
- Get the account for `ON ACCOUNT` grants: `SELECT CURRENT_ACCOUNT();`.

## 5. Checking table size ⭐

Before cloning he showed how to find a table's size (Oracle devs: this replaces DBA_SEGMENTS/db blocks):
```sql
SELECT table_name, active_bytes,
       ROUND(active_bytes/1024/1024, 2)        AS size_mb,
       ROUND(active_bytes/1024/1024/1024, 2)   AS size_gb
FROM   information_schema.tables
WHERE  table_name = 'T_CUSTOMER';
```
- **`ACTIVE_BYTES`** in `INFORMATION_SCHEMA.TABLES` = the table's active storage. Divide by 1024³ for GB. His demo table: ~65M rows ≈ **2 GB**.

## 6. Zero-Copy Cloning ⭐⭐ (the headline topic)

**Problem:** a traditional backup (`CREATE TABLE bkp AS SELECT * FROM t`) **duplicates storage** — a 2 GB table needs another 2 GB, and takes time.

**Snowflake answer — `CLONE`:**
```sql
-- clones a table instantly, with NO storage cost up front
CREATE TABLE t_customer_clone CLONE t_customer;    -- runs in ~1 second
```
- ⭐⭐ **Why "zero-copy":** the clone and the source **share the same underlying micro-partitions** at first — no data is copied, so **no extra storage cost** and it's near-instant.
- ⭐⭐ **Copy-on-write / divergence:** the clone and source are **independent** afterward. Storage cost is incurred **only when data changes** (INSERT/UPDATE/DELETE on either side) — Snowflake then writes **new micro-partitions** for the changed rows. *As long as neither side changes, there's no added storage.*
  - His demo: `DELETE`d a few rows from the **source** → the **clone kept** those rows → so Snowflake now stores the diverged partitions → a small storage cost appears.
- **Clone a database or schema too:**
  ```sql
  CREATE DATABASE dev_db_clone CLONE dev_db;             -- whole database
  CREATE SCHEMA  dev_db.bank_clone CLONE dev_db.dev_schema; -- a schema
  ```
- **Identify clones** via `INFORMATION_SCHEMA.TABLE_STORAGE_METRICS`:
  - A **normal table:** `ID = CLONE_GROUP_ID`.
  - A **clone:** `ID ≠ CLONE_GROUP_ID` (its `CLONE_GROUP_ID` points to the **base table's ID**).
  ```sql
  SELECT table_name, id, clone_group_id
  FROM   information_schema.table_storage_metrics
  WHERE  id <> clone_group_id;     -- lists only cloned tables
  ```
- ⭐ **Real-world uses he gave:**
  1. **QA/test environments** — clone production tables into QA to test against real data with almost no storage cost (vs physically copying prod data like in Oracle).
  2. **Deployment rollback** — clone the DB/schema **before** a release; if the deploy breaks, revert to the clone.
- **Dropping the source doesn't kill the clone:** `DROP TABLE t_customer;` → `t_customer_clone` still exists (and you can `UNDROP` the source via Time Travel). Clones are fully independent objects.

## 7. Time Travel + UNDROP recap (tied to retention) ⭐

He re-proved the Class 25 rule while discussing clone/backup recovery:
```sql
CREATE TABLE t_zero   DATA_RETENTION_TIME_IN_DAYS = 0;   -- no Time Travel
CREATE TABLE t_twoday DATA_RETENTION_TIME_IN_DAYS = 2;   -- 2 days TT
DROP TABLE t_zero;    DROP TABLE t_twoday;

UNDROP TABLE t_twoday;  -- ✅ "successfully restored" (within its 2-day window)
UNDROP TABLE t_zero;    -- ❌ "table does not exist" (retention = 0, nothing to recover)
```
- ⭐ **UNDROP works only if the object has Time-Travel retention left.** `DATA_RETENTION_TIME_IN_DAYS = 0` → **no recovery**.
- Snowflake DML is **auto-commit** (no explicit COMMIT/ROLLBACK by default), which is why Time Travel/UNDROP — not a transaction rollback — is how you recover. ⭐
- To restore after a bad DML on a real table: use **Time Travel** (`AT/BEFORE`) to the moment before the change.

## 8. Previewed for NEXT class ("tomorrow — very important")

- ⭐ **What happens to micro-partitions on INSERT / UPDATE / DELETE** (they're immutable → DML rewrites partitions). *He stressed this one.*
- Then: **clustering** (the long-promised with/without demo), **Search Optimization Service (SOS)**, **Query Acceleration Service (QAS)** — the performance-tuning block.

## 9. Cheat-sheet / quick recall

- **Resource Monitor** = credit-budget guard. **ACCOUNT level** (all WHs, one active) vs **WAREHOUSE level** (one WH). Actions: **Notify / Suspend (let jobs finish) / Suspend Immediately (abort jobs)**. `SHOW RESOURCE MONITORS;` ⭐⭐
- **3 cost types:** **compute** = warehouses, **storage** = databases, **cloud services/stage** = stages (worksheets auto-save to the internal stage). Compute & storage billed separately. ⭐
- **Warehouse ≠ database.** `CREATE DATABASE` and `CREATE WAREHOUSE` are **separate** account privileges. ⭐
- **Table size:** `INFORMATION_SCHEMA.TABLES.ACTIVE_BYTES` (÷1024³ = GB). ⭐
- **Zero-copy clone:** `CREATE TABLE b CLONE a;` → instant, **no storage** until data diverges (copy-on-write); clone & source **share micro-partitions**, then become independent. Works on table/schema/database. ⭐⭐
- **Spot a clone:** `TABLE_STORAGE_METRICS` where `ID <> CLONE_GROUP_ID`. ⭐
- **Clone uses:** QA with prod data; pre-deploy rollback copy. Dropping source ≠ dropping clone.
- **UNDROP** needs Time-Travel retention > 0; DML is **auto-commit** → recover with Time Travel, not ROLLBACK. ⭐
- 📚 Drive folder = **`Interview_Preparation`** (certification details inside) — you already have it.

*End of Class 44 notes. A cost-and-recovery class: Resource Monitors (account vs warehouse, notify/suspend actions), the three cost types, warehouse-vs-database privileges, table sizing, and the headline topic — zero-copy cloning (shared micro-partitions, copy-on-write, QA/rollback uses) — plus a Time-Travel/UNDROP recap. Clustering/SOS/QAS and micro-partition DML behaviour pushed to next class.*
