# Class 37 — Incremental Models (deep-dive) + dbt Tests

**Snowflake — Class 37 Notes**
*Sara — SnowPro Core preparation*

> 🟢 **This is a GOOD class — the incremental deep-dive the trainer flagged as "3–4 questions" (interview context — he never said exam).**
>
> It covers **incremental loading in dbt** (the full mechanics — `is_incremental()`, `{{ this }}`, the auto-generated MERGE), the **`on_schema_change`** config, and **dbt tests** (`not_null`/`unique`/`accepted_values`/`relationships`). The incremental part is the **"3–4 questions"** topic he flagged in Class 36 (interview, not stated as exam; the watermark+MERGE logic underneath does overlap the exam). You also built this hands-on yourself, so it should feel familiar.
>
> **Two things he mentioned beyond the lesson (you asked me to always flag these):**
> - He'll do a **Snowflake Cortex + Copilot workshop** session (likely a Saturday) — Snowflake is running an **event/conference** (8:30–5:30, in-person) he encouraged people to register for with a work email. *Cortex = Snowflake's built-in AI/LLM features — increasingly relevant for jobs, not core SnowPro Core exam yet.*
> - Changes were pushed to **both the dev branch (7am) and `main`** this class.

---

## 0. Context

Continues Class 36. Recap of the **manual Snowflake incremental** (watermark + MERGE), then shows **dbt does the exact same thing automatically** with the `incremental` materialization. Then an intro to **tests**.

---

## 1. ⭐⭐⭐ Incremental models in dbt (trainer-flagged topic — interview; MERGE logic overlaps exam)

### The mental model (know this cold)
- A **normal model** (`table`) **rebuilds every row every run**. Fine for small data, wasteful for huge tables.
- An **incremental model**: **first run = full load** (creates the table with all rows); **every later run = only new/changed rows**, merged in.
- dbt auto-generates the **watermark filter + MERGE** you'd otherwise write by hand (Class 36's manual version).

### The required config
```sql
{{ config(materialized='incremental', unique_key='<id_column>') }}
```
- **`materialized='incremental'`** → use the incremental strategy.
- **`unique_key`** → how dbt matches a row for the MERGE (match → UPDATE, no match → INSERT).

### The `is_incremental()` block (the heart of it) ⭐
```sql
select ...
from {{ source('bronze','raw_events') }}   -- or {{ ref('...') }}

{% if is_incremental() %}
  where event_time > (select max(event_time) from {{ this }})
{% endif %}
```
- **`is_incremental()`** = a macro that is **FALSE on the first run** (so the WHERE is skipped → full load) and **TRUE on later runs** (so the watermark filter applies → only new rows).
- **`{{ this }}`** = refers to **the model's own existing table** (the target). So `MAX(event_time) FROM {{ this }}` = "the newest row I already loaded" = the **watermark**.
- So the filter means: *"only pull source rows newer than what I've already got."*

### What dbt actually does under the hood (seen in debug logs) ⭐
On an incremental (non-first) run, dbt:
1. **Creates a temporary view** holding the changed rows (applying your WHERE filter).
2. **Runs a `MERGE`** into the target: `WHEN MATCHED THEN UPDATE … WHEN NOT MATCHED THEN INSERT …`.
3. **Drops the temporary view.**
> This is **identical** to the manual watermark+MERGE from Class 36 — dbt just wraps it. "We're not doing anything; we just configure it, and dbt builds the temp view, merges, and drops it."

### Common gotcha shown
- A stray **semicolon** inside the model caused `SQL compilation error` — dbt models must **not** end the SELECT with `;`.

---

## 2. ⭐ `on_schema_change` (handling new/changed source columns)

Incremental models can break when the **source table's columns change**. Control this with:
```sql
{{ config(materialized='incremental', unique_key='claim_id', on_schema_change='append_new_columns') }}
```
- **`append_new_columns`** → if the source gains a **new column**, dbt **adds it** to the target automatically (new rows get it; old rows stay NULL for it).
- **Demo:** adding a `mobile` column to source → with `append_new_columns`, the model succeeds and the new column appears. Dropping a column (`ename`) still caused an error referencing the dropped column (append handles *new* columns, not drops).
- Other valid values (worth recognising): **`ignore`** (default — ignore schema changes), **`fail`** (error on any change), **`sync_all_columns`** (add new + remove dropped).

> 💡 Exam/interview nuance: `on_schema_change` only governs **column schema evolution** on incremental models; `append_new_columns` is the most common choice.

---

## 3. ⭐ dbt Tests (data-quality validation)

dbt can validate your data automatically. Defined in a **YAML file** (e.g. `tests/validation.yml` or a schema `.yml`), attached to a model's column.

### The four built-in generic tests ⭐ (map these to SQL constraints)
| dbt test | Equivalent constraint | Checks |
|---|---|---|
| **`not_null`** | NOT NULL | column has no NULLs |
| **`unique`** | UNIQUE | no duplicate values |
| **`accepted_values`** | CHECK | value is in an allowed list |
| **`relationships`** | FOREIGN KEY | value exists in a referenced model/column |
> **`not_null` + `unique` together = a primary key.** `accepted_values` = a CHECK constraint. `relationships` = a foreign key. (Great interview one-liner.)

### Example YAML
```yaml
version: 2
models:
  - name: t_customer_info
    columns:
      - name: customer_id
        tests:
          - not_null
          - unique
```

### Run tests
```
dbt test --select t_customer_info
```
- Demo: inserted a **duplicate** customer_id and a **NULL** customer_id into the source → `dbt test` reported **`not_null` FAILED** and **`unique` FAILED**. ✅ proves the tests catch bad data.
- **`dbt build`** = runs **seeds + models + tests together** (vs `dbt run` = models only). Use `build` to execute the whole project end-to-end in dependency order.
- You can also view the **compiled SQL** of a test (dbt generates a query that returns the offending rows; if it returns any rows, the test fails). **Custom business-rule tests** are possible too (teased for next class).

---

## 4. Lineage for debugging (recap, reinforced)

- With many chained models (seed → staging → intermediate → mart/incremental), tracing dependencies by hand is slow. The **Lineage** tab shows the full graph so you can see what feeds what — he explicitly used it to figure out *"where does this data come from?"* while debugging. (Confirms the Class 36 lineage value.)

---

## 5. Previewed for NEXT class

- More **tests** — including **custom / business-rule tests**.
- A **Snowflake Cortex + Copilot** workshop session (separate, likely a Saturday — AI features, not core exam).

---

## 6. Cheat-sheet / quick recall ⭐ (exam-focused)

- **Incremental model:** first run = **full load**; later runs = **only new/changed rows** merged in. Config: `materialized='incremental'` + **`unique_key`**. ⭐⭐⭐
- **`is_incremental()`** = FALSE on first run (full load), TRUE after (applies watermark filter). **`{{ this }}`** = the model's own target table.
- **Watermark pattern:** `WHERE ts_col > (SELECT MAX(ts_col) FROM {{ this }})`. Under the hood dbt = **temp view → MERGE (match=update / no-match=insert) → drop view**. Same as manual Snowflake MERGE.
- **No trailing semicolon** in dbt models.
- **`on_schema_change`:** `append_new_columns` (add new cols), `ignore` (default), `fail`, `sync_all_columns`. Handles column evolution on incremental models. ⭐
- **dbt tests:** `not_null`, `unique`, `accepted_values`, `relationships`. **not_null+unique = PK; accepted_values = CHECK; relationships = FK.** ⭐
- **`dbt run`** = models only. **`dbt seed`** = CSVs. **`dbt test`** = tests. **`dbt build`** = all of them together, in dependency order. ⭐
- **Lineage** = dependency graph for build order + debugging.
- **(Career note, not exam):** Snowflake **Cortex** = built-in AI/LLM; workshop/event mentioned.

*End of Class 37 notes. Strong class: delivered the trainer-flagged (interview) incremental deep-dive (is_incremental/{{this}}/MERGE + on_schema_change) and dbt tests (not_null/unique/accepted_values/relationships). You built incremental hands-on yourself this session, so it should stick.*
