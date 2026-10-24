# Class 36 — dbt Macros + Incremental Loads in Snowflake (watermark + MERGE)

**Snowflake — Class 36 Notes**
*Sara — SnowPro Core preparation*

> 🟡 **Honest labeling (mixed class — read this).**
>
> **First ~40 min = dbt** (macros, `config`, sources, lineage) — mostly **job skill, not exam**, continuing Classes 33–34.
> **Last ~12 min = a genuinely useful Snowflake topic: INCREMENTAL loading** (max-date watermark + `MERGE`) — **cert + job relevant** and done as a real hands-on.
>
> **⭐ EXPLICIT EXAM SIGNAL (rare — he almost never does this):** at the end he said the **next class is on incremental models**, that there are **"three different types of incremental,"** and — his exact words — **"this is very important, at least you will find three to four questions from the same topic."** So **incremental / incremental loading is worth real study time** for the exam. Full detail comes in **Class 37**.
>
> **Also worth grabbing:** he offered to **share a complete SQL reference document** (joins, subqueries, set operators, aggregate / analytical / regex functions). **Ask him for it** — that's directly exam-useful. And **SOS is STILL not covered** (pending since Class 30).

---

## 0. Context

Continues the dbt healthcare project (bronze→silver→gold). New dbt concept = **macros** (reusable logic). Then pivots to **how incremental loading actually works in Snowflake** — the valuable part.

---

## 1. ⭐⭐ Incremental loading in pure Snowflake (watermark + MERGE) — the cert/job gold

This is the part to actually learn. He built it by hand in Snowflake (no dbt) so you see the mechanics.

### The idea
Instead of reloading a whole source table every run (**full load**), only move **new/changed rows** since the last run. This is **incremental loading**, and it's a core data-engineering pattern.

### The mechanism: a "watermark" column
- The source table has a timestamp column (here **`UPDATED_DATE`**). Every insert/update stamps it.
- The target (incremental) table tracks the **highest timestamp it has already loaded** = the **watermark**.
- Each run: *"give me source rows where `UPDATED_DATE > (MAX(UPDATED_DATE) in target)`"* → only the new/changed rows.

### The flow demonstrated (step by step)
1. **First run = full load.** Target empty → everything from source copied in.
2. Find the watermark: `SELECT MAX(updated_date) FROM target_incremental;`
3. Capture changes into a **temporary view/table**:
   ```sql
   CREATE OR REPLACE TEMPORARY VIEW v_changes AS
   SELECT * FROM source_emp
   WHERE updated_date > (SELECT MAX(updated_date) FROM emp_incremental);
   ```
   → this view holds **only the rows inserted or updated since last load.**
4. Apply them with **`MERGE`** (upsert) onto the final table:
   ```sql
   MERGE INTO emp_incremental AS tgt
   USING v_changes AS src
     ON tgt.emp_no = src.emp_no
   WHEN MATCHED THEN UPDATE SET tgt.salary = src.salary, tgt.updated_date = src.updated_date, ...
   WHEN NOT MATCHED THEN INSERT (...) VALUES (...);
   ```
   - **MATCHED → UPDATE** (row already exists, changed) ⭐
   - **NOT MATCHED → INSERT** (brand-new row) ⭐
5. Re-check the watermark → it has advanced; a fresh run finds "no changes" until the source changes again.

### Key takeaways ⭐
- **The whole thing is driven by the timestamp (`UPDATED_DATE`) watermark.** No timestamp → no reliable incremental.
- **`MERGE` = the upsert workhorse** (you know it from SCD2, Classes 23–24 — same tool).
- **First load is always a full load**; subsequent loads are incremental.
- dbt wraps all of this in one setting — **`materialized = 'incremental'`** + a **unique key** — so you don't hand-write the watermark/MERGE. But **knowing the manual Snowflake mechanics is the exam-relevant bit.**

---

## 2. Window / analytical functions got named ⭐ (exam-relevant — recall)

While walking a `fact_claims_monthly` model, he listed the analytical functions and contrasted them with aggregates:
- **Aggregates:** `SUM`, `MIN`, `MAX`, `AVG`, `COUNT`.
- **Analytical / window:** `RANK`, `DENSE_RANK`, `ROW_NUMBER`, `LAG`, `LEAD` — plus **running totals** and **moving averages** (e.g. 3-month average, prev-vs-current-month comparison via `LAG`).
- These **are** SnowPro Core content (you've used `ROW_NUMBER`/`QUALIFY` already in Classes 24 & 30). Good to keep sharp: **window functions compute across a set of rows *without collapsing* them (unlike `GROUP BY`).**
- ➡️ **He offered a full SQL reference doc** covering joins, subqueries, set operators, aggregates, analytical, regex — **ask for it.**

---

## 3. Masking-by-CASE pattern (business idea behind data masking)

- Demo: hide real `MARKET_SEGMENT` values (MACHINERY, BUILDING, AUTOMOBILE…) behind business labels via a `CASE` expression; same idea used for medical **diagnosis/procedure codes** (show code, not disease name).
- *Cert link:* this is the plain-SQL version of the rationale for **dynamic data masking / secure views / column-level security** — the real Snowflake features weren't taught here, just the concept.

---

## 4. dbt reference (job skill — NOT exam) — brief

- **Macros** = reusable logic (dbt's "functions"). Created in `macros/` with `{% macro name(param) %} … {% endmacro %}`; called as `{{ name(column) }}`. Use when the same logic (e.g. a `CASE` classifier) repeats across many models — write once, reference everywhere.
- Built-in helper shown: **`safe_divide`** (avoids divide-by-zero).
- **`config`** macro sets materialization (`{{ config(materialized='table') }}`); default is **view**. Running a model that switches view→table **drops the view then creates the table** (seen in the debug logs).
- **`ref()`** = reference another model; **`source()`** + `sources.yml` = reference a declared raw source without hardcoding db/schema.
- **Lineage** tab shows the dependency graph (mart ← intermediate ← staging ← seed/source).
- **`packages.yml`** = declare external dbt packages you want to use.

---

## 5. Previewed for NEXT class (Class 37) — ⭐ flagged important

- **Incremental materialization in dbt** + **"three different types of incremental."** ⭐ *He explicitly said ~3–4 exam questions come from this — prioritize it.*
- Snapshots / SCD2 in dbt (he'll "come back to snapshot").
- **SOS still owed** (not mentioned again).

---

## 6. Cheat-sheet / quick recall

- **Incremental load = move only new/changed rows** since last run, via a **timestamp watermark** (`WHERE updated_date > MAX(updated_date in target)`) + **`MERGE`** (MATCHED→UPDATE, NOT MATCHED→INSERT). First load = full load. ⭐⭐
- **`MERGE`** is the upsert tool (same as SCD2). The **watermark timestamp drives everything.**
- dbt does all this with **`materialized='incremental'` + unique_key** — but know the **manual Snowflake mechanics** for the exam.
- **Window functions** (`RANK`, `DENSE_RANK`, `ROW_NUMBER`, `LAG`, `LEAD`, running totals/moving avgs) vs **aggregates** (`SUM`/`MIN`/`MAX`/`AVG`/`COUNT`) — exam-relevant; window fns don't collapse rows. ⭐
- **CASE-masking** = concept behind dynamic data masking / secure views (no feature taught here).
- **dbt macros/config/ref/source/lineage/packages.yml** = job skill, not exam.
- **⭐ EXAM SIGNAL:** incremental = "3–4 questions," deep-dive next class. **Also: ask the instructor for his full SQL reference document.**
- **SOS still pending.**

*End of Class 36 notes. Mixed class: dbt macros (non-exam) + a solid incremental-load hands-on in Snowflake (watermark + MERGE, cert-relevant). Instructor explicitly flagged incremental as heavily tested (~3–4 questions) for next class.*
