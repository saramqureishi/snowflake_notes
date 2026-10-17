# Class 31 — Caching Recap + the 31-Day Result-Cache Rule

**Snowflake — Class 31 Notes**
*Sara — SnowPro Core preparation*

> ⚠️ **Honest labeling (read this first).** This was a **recap / consolidation class**, almost entirely a hands-on re-demonstration of the **three caches** from Class 30 (result cache, local/warehouse disk cache, metadata cache). It is **light on new content.**
>
> **The topics you were promised** at the end of Class 30 — **Query Acceleration Service (QAS), Search Optimization Service (SOS), clustering keys, pruning** — were **explicitly deferred to the next ("Saturday") session.** They are *not* taught here. Direct words from the instructor: *"today we will talk about the caches… [next session] we are going to talk about these services — search optimization, pruning, clustering key, query acceleration service."* The class literally ends with *"we will continue this tomorrow."*
>
> **The ONE genuinely new, exam-worthy fact in this class** is the **result cache 24-hour → 31-day extension rule** (section 2). Everything else you already have from Class 30. Don't spend long re-reading the recap — just lock in section 2.

---

## 0. Where this sits in the story

Class 30 introduced the three caches and teased QAS/SOS/clustering for "next class." Class 31 turned out to be a **practice/recap session** on caching (the instructor was waiting for large sample tables to load and filled the time by re-proving the cache behaviour live), then **punted the big new topics to the following session.** So treat Class 31 as "caching, reinforced + one new rule," and expect the real QAS/SOS/clustering material in **Class 32**.

---

## 1. The three caches — quick recap (all from Class 30, re-demonstrated)

| Cache | Lives where | Survives warehouse suspend? | Busted by | Typical "proof" in Snowsight |
|---|---|---|---|---|
| **Result cache** | Global service layer (account-wide) | ✅ Yes (not tied to a warehouse) | **Any data change** (INSERT/UPDATE/DELETE), or query text change, or `USE_CACHED_RESULT=FALSE` | Query profile shows **"Query result reuse"** |
| **Local / warehouse (disk) cache** | On the warehouse's local SSD | ❌ **No — cleared on suspend** | Suspend, or cache eviction | Query profile **"% scan from cache"** (e.g. 10%, 100%) |
| **Metadata cache** | Service layer (metadata store) | ✅ Yes | New DML changing the stats | Profile shows **"Metadata-based result"** / "Metadata operation" |

**Order of preference a query uses (recap ⭐):** result cache → local disk cache → remote disk (storage). The instructor walked this live, repeatedly.

### Things demonstrated live (nothing new, but good reinforcement)
- `SHOW WAREHOUSES;` → confirmed a warehouse was **suspended** ("you cannot execute queries… warehouse not available").
- `SHOW PARAMETERS LIKE 'USE_CACHED_RESULT';` → verify result cache on/off.
- `ALTER SESSION SET USE_CACHED_RESULT = FALSE;` → disable result cache so you can *see* the local-disk cache behaviour underneath it.
- Re-running an identical query returned in **<1 second** → "query result reuse" from the **result cache**.
- **% scan from cache** readings in the query profile:
  - `0%` after a suspend (local disk cache gone) → data came from **remote disk**.
  - `10%` on a partial re-read.
  - `100%` when the full result was already on the warehouse's local disk.

### Result cache depends on **database + schema**, NOT on the warehouse ⭐ (nice exam nuance)
- The instructor created the **same table names in two different schemas** and showed the first run in a new schema **hit remote disk** (fresh), even though an identical-looking query had run in another schema.
- **Takeaway:** the result cache key includes the **exact SQL text + the database/schema context + the underlying data being unchanged** — it is **account-wide and warehouse-independent** (switching warehouses still reuses the result cache), but it is **schema/database-sensitive.**

---

## 2. ⭐⭐⭐ NEW: The result-cache 24-hour → 31-day extension rule

**This is the one genuinely new, high-value exam fact in the whole class. Memorize it.**

- A query's result stays in the **result cache for 24 hours** after it runs.
- **Every time the same query is reused within that window, the 24-hour timer resets** (extends by another 24h from the reuse moment).
- This rolling extension can continue **up to a hard maximum of 31 days from the time the query was *first* executed.**
- **After 31 days the cached result is purged**, no matter how often it's reused. The next run then hits **remote disk**, regenerates the result, and starts a brand-new 24h/31-day cycle.

### Memory hook
> **"24-hour cache, but it rolls — reuse keeps it alive one more day at a time, up to 31 days total, then it's gone."**

### Worked example from class
- Run query at **10:00 Oct 13** → result cached, valid until 10:00 Oct 14.
- Reuse it at **21:00 Oct 13** → window now extends to **21:00 Oct 14.**
- Reuse again **19:00 Oct 14** → extends to **19:00 Oct 15**… and so on.
- Keep reusing daily → it survives, but **only until 31 days after the very first run (Oct 13)**, then it's purged.

### Exam phrasing to recognise (True/False style)
> *"Each time a persisted query result is reused, Snowflake resets the 24-hour retention period, up to a maximum of 31 days from the date/time the query was first executed. After 31 days the result is purged and a new result is generated on the next run."* → **TRUE.**

**Cert trap:** people memorize "24 hours" and stop. The sneaky follow-up is **"what's the maximum?" → 31 days.**

---

## 3. Exam questions the instructor read aloud (worth recognising)

These were multiple-choice items shown on screen; capturing the gist so you recognise the pattern:

1. **"Which cache runs on a 24-hour clock?"** → **Result cache** (24h, extendable to 31 days).
2. **"A query took 2–3 minutes; you ran it again and it returned in under a second. What happened?"** → **Result cache hit** (query result reuse).
3. **"Query history shows columns: query ID, SQL text, warehouse name, warehouse size, session ID, start/end time. Which indicate a *compute cost* was incurred?"** → the **warehouse-related columns** (a warehouse ran, so **credits/compute were used**); a pure result-cache hit or metadata operation uses **no warehouse → no compute cost.**
4. **"Warehouse auto-suspend = 5 min, result cache disabled — rerun behaviour?"** → with result cache off and the warehouse warm, you'd read from **local disk cache**; after suspend, from **remote disk.**

> 💡 **Big exam principle reinforced:** **Result cache and metadata cache hits are FREE (no warehouse → no credits).** Only reads that actually spin a warehouse (local disk cache miss → remote disk) cost compute. This is a classic SnowPro cost question.

---

## 4. Warehouse sizing & vertical scaling (recap, one term named)

The large sample tables (`store_sales`, `store`, `item`, etc.) were slow to create, so the instructor used the wait to recap sizing:

- **T-shirt sizes:** XS → S → M → L → XL → 2XL → 3XL → 4XL. Each step up ~**doubles** compute (loose analogy given: "like 2GB, 4GB, 8GB, 16, 32, 64…"). XS is the baseline.
- Created a `QA_WAREHOUSE` at **Large** via **Compute → Warehouses → Create**, and also resized an existing warehouse (L → 4XL) to show it's a simple property change.
- **Key terms:**
  - **`AUTO_RESUME`** — warehouse starts automatically when a query needs it.
  - **`AUTO_SUSPEND`** — warehouse suspends after N seconds/minutes idle (demo used 2 min; mentioned 5 min). **On suspend, the local disk cache is cleared** (ties back to section 1).
- **Increasing warehouse SIZE to make a single slow query faster = ⭐ VERTICAL SCALING.** (Contrast — *not* covered here but worth noting for the exam: adding **more clusters** = **horizontal scaling** / multi-cluster, which the instructor said he'd cover later.)
- **Dev vs QA environment aside:** dev = test logic on small/synthetic data; QA = test on full-volume real data (why QA needs a bigger warehouse).

---

## 5. Metadata cache — re-demonstrated (recap)

- Ran `SELECT COUNT(*) FROM <table>;` → query profile said **"Metadata-based result"** → answered **from the metadata cache, no warehouse scan.**
- Ran `SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE';` → **"Metadata operation."**
- **Metadata-cache operations:** `COUNT(*)`, `MIN`, `MAX`, and similar stats Snowflake already tracks per micro-partition → returned instantly, **free**, no warehouse needed.

---

## 6. Previewed for NEXT class (⚠️ the real new topics, deferred)

The instructor explicitly said these are the **next session's** material — they are **NOT** in Class 31:

- **Pruning** (scan only the micro-partitions you need) — intro was in Class 30; deep-dive next.
- **Clustering keys** (improve pruning on big tables).
- **Search Optimization Service (SOS)** — speeds up selective point-lookup queries.
- **Query Acceleration Service (QAS)** — offloads parts of a scan to serverless compute.
- **Multi-cluster warehouses / horizontal scaling** — also teased here, deferred.

> So **Class 32 is the one that actually teaches QAS / SOS / clustering keys.**

---

## 7. Cheat-sheet / quick recall

- **3 caches:** result (service layer, account-wide, survives suspend, **free**), local/warehouse disk (on-warehouse SSD, **cleared on suspend**, costs compute to populate), metadata (service layer, free, powers `COUNT`/`MIN`/`MAX`).
- **Preference order:** result → local disk → remote disk.
- **Result cache life:** **24 hours**, resets on each reuse, **max 31 days** from first run, then purged. ⭐⭐⭐
- **Result cache is warehouse-independent** but **database/schema-sensitive** and **data-change-sensitive** (any DML busts it).
- **`USE_CACHED_RESULT`** session param toggles the result cache; check with `SHOW PARAMETERS LIKE 'USE_CACHED_RESULT'`.
- **Local disk cache** = check **"% scan from cache"** in the query profile; `0%` right after a suspend.
- **Free reads** (no credits): result-cache hits + metadata operations. **Paid reads:** anything that spins a warehouse.
- **Vertical scaling** = bigger warehouse size (one query faster). **Horizontal scaling** = more clusters (more concurrency) — *next class.*
- **AUTO_SUSPEND clears local disk cache; AUTO_RESUME restarts the warehouse on demand.**

*End of Class 31 notes. Topic = caching recap + the 24h→31-day result-cache rule. QAS / SOS / clustering keys were deferred to Class 32 (honest labeling — this class did not cover them).*
