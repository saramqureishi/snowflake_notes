# Class 42 — Back to Snowflake: Performance Topics Intro (Clustering Demo, Scaling, Snowsight AI Assistant)

**Snowflake — Class 42 Notes**
*Sara — SnowPro Core preparation*

> 🟢 **The dbt series is over** ("dbt is done, a few topics pending, we'll cover them in two sessions"). This class is back on **Snowflake** and is **exam-relevant**, but it's mostly a **preview**: a clustering demo that didn't finish, plus the list of performance/admin topics for the next sessions. The real comparisons are promised for **Monday**.
>
> **Things he said that matter to you (flagged as you asked):**
> - 📚 **Certification material:** a student asked for certification details and material. He said he'll **upload a Drive folder with "everything about the certification"** (that day, by ~5:30–6pm). **Ask him for that link.**
> - 💬 He's adding people to a **WhatsApp group** for Snowflake events, and will explain events roughly bi-weekly.
> - 🎪 Snowflake community events page (search "Snowflake community events"); an in-person event was on that day in **Nagpur**.
>
> ⚠️ **One thing he said that's not exam-accurate** (see section 4): he described **QAS as "vertical scaling."** For the exam, **vertical scaling = resizing the warehouse**; QAS is a separate serverless feature.

---

## 1. Snowsight AI assistant (demo, not exam)

- In Snowsight's workspace he showed the built-in **AI assistant** (he called it "Cocoa"; likely Snowflake's **Cortex Code / Copilot**-style assistant). You prompt it like ChatGPT/Copilot, it can generate SQL and explain concepts, and you can pick the underlying model (default "auto").
- He asked it for a clustering-key example and used the generated script to build the demo below.
- Career-relevant, **not SnowPro Core content.**

## 2. Clustering demo (exam-relevant, but unfinished)

- Created a `SALES` table **without** a clustering key, loaded **~15M generated rows**, and ran a region-wise `SUM(amount)` between two dates.
- `SYSTEM$CLUSTERING_INFORMATION('db.schema.table', '(col)')` on an unclustered table → **"invalid clustering keys or table is not clustered"** (same as Class 32).
- Created a second table **with** a clustering key, two ways:
  ```sql
  CREATE TABLE sales_with_cluster (...) CLUSTER BY (region, sale_date);   -- at creation
  ALTER TABLE sales_with_cluster CLUSTER BY (region, sale_date);          -- on an existing table
  ```
- The timing comparison was **inconclusive in class** (the clustered query took ~2 min on X-Small). He'll redo it on Monday with proper data.
- ⭐ **Gotcha he pointed out:** wrapping the filter column in a function (he'd used **`TO_DATE()`** in the `WHERE`) is "not the correct way." Applying functions to the filtered/clustered column can **prevent partition pruning**. Filter on the raw column value instead.
- Remember from Class 32: clustering only pays off on **large** tables, and **automatic reclustering uses credits**.

## 3. Upcoming topics he listed (the "data admin" block) ⭐

All exam topics. He said "you should have some idea on these":
- **Search Optimization Service (SOS)** (finally on the list)
- **Query Acceleration Service (QAS)**
- **Clustering keys** (with/without comparison)
- **Resource monitors** ⭐ (cost control; new topic)
- **What happens in the background on INSERT / UPDATE / DELETE** (micro-partitions are immutable, so DML rewrites partitions)
- **Horizontal vs vertical scaling**

## 4. Horizontal vs vertical scaling ⭐ (exam-critical; with a correction)

Shown in **Compute → Warehouses → Create → Advanced options**:

| | Vertical scaling (scale **up**) | Horizontal scaling (scale **out**) |
|---|---|---|
| What you change | **Warehouse size** (XS → S → M → L → XL…, each step ~2× compute and credits) | **Number of clusters** (multi-cluster warehouse: min/max cluster count) |
| Solves | **Slow/complex queries** | **Concurrency / queuing** (many users or queries at once) |
| Edition | Any | **Enterprise+** |

- ⚠️ **Correction:** in class he said *"query acceleration service is nothing but vertical scaling."* **For the exam that's wrong.** Vertical scaling = resizing the warehouse. **QAS** offloads parts of *eligible* large scans to **separate serverless compute**, capped by the **scale factor**. It doesn't change the warehouse size. QAS is closer to a per-query boost than to either kind of scaling.
- He also noticed **new Gen2 warehouse options** in the UI (e.g. a query throughput multiplier / max query performance level; your own `SHOW WAREHOUSES` output earlier had `query_throughput_multiplier` and `max_query_performance_level` columns). These are recent features, so don't expect them on the exam yet.
- AUTO_RESUME / AUTO_SUSPEND recap (Class 31).

## 5. Previewed for NEXT class (Monday)

- Clustering with vs without, with real numbers.
- Horizontal/vertical scaling and QAS in practice.
- Agenda/details of the Snowflake event he attended.

## 6. Cheat-sheet / quick recall

- dbt series finished; back to Snowflake performance/admin topics.
- Add a clustering key: `CLUSTER BY (cols)` at `CREATE TABLE`, or `ALTER TABLE … CLUSTER BY (cols)`. Check with `SYSTEM$CLUSTERING_INFORMATION`.
- **Don't wrap the filter column in a function** (e.g. `TO_DATE(col)`); it can block pruning. ⭐
- **Vertical = bigger warehouse** (complex queries). **Horizontal = more clusters** (concurrency, Enterprise+). **QAS ≠ vertical scaling**: it's serverless offload for eligible queries. ⭐⭐
- Upcoming: SOS, QAS, clustering, **resource monitors**, DML and micro-partitions, scaling.
- 📚 **Action:** get the trainer's **certification-material Drive folder**.

*End of Class 42 notes. A short preview class back on Snowflake: clustering demo (unfinished), the admin/performance topic list (SOS, QAS, clustering, resource monitors, scaling), horizontal vs vertical scaling (with a correction on QAS), and his promise of a certification-material folder.*
