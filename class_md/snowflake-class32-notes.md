# Class 32 — Query Acceleration (QAS), Micro-partitions, Pruning & Clustering Keys

**Snowflake — Class 32 Notes**
*Sara — SnowPro Core preparation*

> ✅ **This is the class you were waiting for** — it finally teaches **Query Acceleration Service (QAS)**, **micro-partitions & pruning**, and **clustering keys**, all with live hands-on.
>
> ⚠️ **Honest labeling:** **Search Optimization Service (SOS) was deferred *again*** — only named at the end, promised for the next session. The last ~8 minutes went off into **dbt (data build tool)**, which is **not SnowPro Core exam material** — captured briefly at the bottom and labeled as a tangent, not padded.

---

## 0. Where this sits in the story

Class 30 intro'd caching + teased QAS/SOS/clustering. Class 31 was a caching recap (QAS/SOS/clustering slipped a class). **Class 32 delivers QAS + pruning + clustering keys.** SOS is still pending → expect it in **Class 33**.

---

## 1. Query Acceleration Service (QAS) ⭐⭐

### The idea
QAS lets Snowflake **temporarily borrow extra serverless compute** to speed up a query whose work is too big for the warehouse it's running on — **without permanently resizing the warehouse.** Think "elastic boost for the heavy parts of a scan."

- Instructor's mental model: enabling QAS can make a query behave as if the warehouse were up to **N× bigger** for that query (he used a RAM analogy: "4 GB × 8 = 32 GB"). The "N" is the **max scale factor**.

### The two warehouse parameters ⭐
| Parameter | What it does |
|---|---|
| **`ENABLE_QUERY_ACCELERATION`** | Turns QAS on/off for the warehouse (TRUE/FALSE). |
| **`QUERY_ACCELERATION_MAX_SCALE_FACTOR`** | Caps how much extra serverless compute QAS may add, as a multiple of the warehouse size (e.g. 8 → up to 8× the warehouse's compute; 0 = no limit). |

```sql
ALTER WAREHOUSE my_wh SET
  ENABLE_QUERY_ACCELERATION = TRUE
  QUERY_ACCELERATION_MAX_SCALE_FACTOR = 8;   -- demo later changed 8 -> 11
```

### Check whether a query is even eligible ⭐⭐ (the key hands-on)
Before enabling, ask Snowflake if QAS would help, using the **`SYSTEM$ESTIMATE_QUERY_ACCELERATION`** function. It returns JSON, so wrap it in `PARSE_JSON` to read it cleanly:

```sql
SELECT PARSE_JSON(SYSTEM$ESTIMATE_QUERY_ACCELERATION('<query_id>'));
```

The JSON tells you:
- **`status`** — `eligible` (QAS can help) or `ineligible` (it can't / won't).
- An **estimated runtime at different scale factors**, e.g. in class: ~**38 s at 8×**, ~**34 s at 11×** vs the un-accelerated **~2 min 37 s**. (More scale factor → a bit faster, with diminishing returns.)

### ⭐ The #1 exam point about QAS: it does NOT apply to every query
> Even with `ENABLE_QUERY_ACCELERATION = TRUE`, **Snowflake itself decides, per query, whether to accelerate.** Queries that aren't scan-heavy come back **`ineligible`** (demo: a tiny `SELECT … FROM employee` was ineligible; a huge `store_sales` scan was eligible). Enabling QAS ≠ "every query gets faster."

### Gen1 vs Gen2 warehouses (default behaviour) ⭐
- **Gen2 warehouses:** QAS is **enabled by default** (recent change, last couple of months per the instructor).
- **Gen1 warehouses:** QAS is **disabled by default** — you must turn it on (checkbox under **Create Warehouse → Advanced options**, or `ALTER WAREHOUSE`).
- You can see the generation on the warehouse in **Compute → Warehouses**.

---

## 2. Micro-partitions & Pruning ⭐⭐ (exam-heavy)

### Micro-partitions
- When you load data, Snowflake **automatically splits a table into micro-partitions** (small, immutable, columnar storage units). You don't create or manage them.
- A huge table (demo: **~28.8 billion rows** in `store_sales`) ends up with **tens of thousands of micro-partitions** (demo showed ~38K).

### Pruning = scan only the partitions you need ⭐⭐
- **The kitchen-shelf analogy:** looking for one item across 10 shelves — if you *know* it's on shelf 3, you open only shelf 3, not all 10. Opening only the needed shelves = **pruning**.
- In the query profile, compare two numbers (scroll right on the query detail):
  - **Partitions total** — how many the table has.
  - **Partitions scanned** — how many this query actually read.
- **Good pruning = scanned ≪ total.** If scanned ≈ total, there's almost no pruning (you're effectively full-scanning).
- **You don't do anything to get basic pruning** — Snowflake prunes automatically based on the micro-partition min/max metadata and your `WHERE` filter.
- **Analogy to other DBs:** pruning is conceptually like an **index** in Oracle/SQL Server — it avoids scanning the whole table. (Snowflake has no traditional indexes; pruning + clustering + SOS fill that role.)

---

## 3. Clustering Keys ⭐⭐ (the hands-on highlight)

### The problem
On a very large table, the physical ordering of rows across micro-partitions may not match how you filter. If the values you filter on are **scattered across many partitions**, even a selective `WHERE` has to scan lots of partitions → weak pruning.

### The fix: define a clustering key
A **clustering key** tells Snowflake which column(s) to **co-locate** rows by, so filtering on that column touches **fewer partitions** → better pruning.

### Check current clustering first
```sql
SELECT SYSTEM$CLUSTERING_INFORMATION('<table>', '(<column>)');
```
- On an un-clustered table it reports **"invalid clustering keys / table is not clustered."**

### Add a clustering key
```sql
ALTER TABLE <table> CLUSTER BY (<column>);
```
- After this, `SYSTEM$CLUSTERING_INFORMATION` returns real stats (the table is now clustered on that column).

### The before/after proof (demo numbers) ⭐
Same filtering query, checking **partitions scanned**:
- **Before clustering:** ~**8,739** partitions scanned.
- **After `CLUSTER BY`:** ~**7,138** partitions scanned (same **762** rows returned).
- → **Fewer partitions scanned = better pruning = faster/cheaper.** That's the whole point of a clustering key.

> 💡 **Exam framing:** clustering keys are for **large tables** where queries filter on a specific column and natural pruning is poor. They **improve pruning**; they don't change results. Snowflake can also **auto-recluster** in the background (maintenance cost).

---

## 4. Search Optimization Service (SOS) — named only, DEFERRED ⚠️

- Mentioned as **"another way to improve this"** beyond clustering, then explicitly pushed to the next session: *"we'll talk about SOS in tomorrow's session."*
- **Not taught in Class 32.** For now just know the one-liner: **SOS speeds up highly selective point-lookup / equality searches** on large tables (complementary to clustering). Full treatment = **Class 33**.

---

## 5. dbt (data build tool) — end-of-class tangent (NOT exam material) ⚠️

Captured for completeness only — **dbt is not on the SnowPro Core exam**; don't spend study time here:
- **dbt = a transformation ("T" of ELT) tool.** In a Snowflake medallion setup (**bronze → silver → gold**), dbt reads from Snowflake and writes back to Snowflake — e.g. transform a raw staging table (`id, first_name, last_name`) in **bronze** into a **silver** table with a combined `name` column.
- Source = Snowflake (bronze), target = Snowflake (silver/gold); gold = reporting layer.
- **dbt Cloud** = a browser UI, no install (instructor started creating a free account at `getdbt.com`, using a temp email, but ran out of time). Deferred to a later session.

---

## 6. Previewed for NEXT class

- **Search Optimization Service (SOS)** — the real deep-dive (finally).
- More **dbt** on a high level (non-exam).

---

## 7. Cheat-sheet / quick recall

- **QAS** = borrow **serverless compute** to speed heavy scans without permanently resizing the warehouse.
- **Two QAS params:** `ENABLE_QUERY_ACCELERATION` (on/off) + `QUERY_ACCELERATION_MAX_SCALE_FACTOR` (cap as a multiple of warehouse size; `0` = unlimited).
- **Eligibility check:** `SELECT PARSE_JSON(SYSTEM$ESTIMATE_QUERY_ACCELERATION('<query_id>'))` → `status` = eligible/ineligible + estimated time per scale factor.
- **QAS is per-query and Snowflake-decided** — enabling it does NOT accelerate every query; small queries come back **ineligible**. ⭐
- **Gen2 warehouses: QAS on by default. Gen1: off by default.** ⭐
- **Micro-partitions** = automatic, immutable, columnar storage units; you never manage them.
- **Pruning** = scanning only needed partitions; compare **partitions scanned vs total** in the query profile; automatic, driven by min/max metadata + `WHERE`.
- **Clustering key:** `ALTER TABLE t CLUSTER BY (col)` → co-locates rows → **fewer partitions scanned** → better pruning. Check with `SYSTEM$CLUSTERING_INFORMATION('t','(col)')`. For **large** tables with poor natural pruning. ⭐⭐
- **Snowflake has no traditional indexes** — pruning + clustering keys + (next class) SOS do that job.
- **SOS** = selective point-lookup accelerator — **deferred to Class 33.**
- **dbt** = transformation tool (bronze→silver→gold); **not exam material.**

*End of Class 32 notes. Topics actually covered = QAS, micro-partitions/pruning, clustering keys (all hands-on). SOS deferred again; dbt was a non-exam tangent (honest labeling).*
