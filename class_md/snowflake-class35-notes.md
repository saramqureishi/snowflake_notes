# Class 35 — dbt Part 3: Intermediate/Mart Models, sources.yml, packages & Surrogate Keys

**Snowflake — Class 35 Notes**
*Sara — SnowPro Core preparation*

> 🟡 **Honest labeling.** Third dbt class — continues the medallion build (staging → **intermediate → mart**). Mostly **job skill, not SnowPro Core exam**, BUT it has a few genuinely useful bits:
> - **`sources.yml`** (dynamically resolve database/schema — the trainer said *"you may get different questions on how to derive the database/schema name dynamically"*) ⭐
> - **`packages.yml` + `dbt_utils`** (external packages) ⭐
> - **Surrogate keys** via `dbt_utils.generate_surrogate_key()` — which **internally uses `MD5`**, tying straight back to your SCD2 **hash-key** notes (Classes 23–24). ⭐
>
> *(This is the class that was accidentally double-posted as "34/35" — now corrected. It sits between Class 34 and Class 36.)*
>
> **You've already done hands-on for `config`, `sources.yml`, intermediate/mart models yourself** this session — so most of this will feel familiar.

---

## 0. Context

Builds the full medallion flow on the healthcare data: **seeds → staging models → intermediate models (joins + derived fields) → intermediate summary (aggregates) → mart/fact models.** Then introduces external packages + surrogate keys.

---

## 1. The model layers (recap, now with intermediate + mart) ⭐

The dbt project layering the trainer uses (good interview structure to know):

| Layer | Folder | What it does |
|---|---|---|
| **Seed** | `seeds/` | raw CSVs → tables |
| **Staging** | `models/staging/` | 1:1 light cleanup of each raw table (cast types, derive simple flags) |
| **Intermediate** | `models/intermediate/` | **joins** multiple staging models + derives cross-table fields |
| **Mart (fact/dim)** | `models/marts/` | business-ready final tables (often aggregated), the "gold" layer |

- **Intermediate example** (`int_claims_enriched`): joins `stg_claims` + `stg_members` + `stg_providers` + `stg_plans` on member/provider/plan IDs → derives discount %, unpaid amount, length-of-stay, admit year/month/quarter. These fields come from **multiple tables**, hence the join.
- **Intermediate summary** (`int_member_claim_summary`): reads the enriched model and applies **aggregates** (`COUNT`, `MIN`, `MAX`, `AVG`) → total/paid/denied claims per member.
- Each layer **`ref()`s the layer below it** → lineage chains seed → staging → intermediate → mart.

---

## 2. ⭐ `sources.yml` — dynamically resolve database/schema (trainer flagged as a likely interview question)

**The problem:** if 50 models hardcode `DEV_DB.BRONZE.customers`, and the source schema later changes, you'd edit all 50 files. **Hardcoding = bad.**

**The fix:** declare raw sources once in **`sources.yml`**, reference them with the **`source()`** macro. Change the schema in **one place** → all models update.

```yaml
# models/sources.yml
version: 2
sources:
  - name: s1
    database: DEV_DB
    schema: CUSTOMER_SCHEMA      # change this ONE line → all 50 models follow
    tables:
      - name: customers
      - name: orders
      - name: payment
```
```sql
-- in a model, instead of hardcoding DEV_DB.CUSTOMER_SCHEMA.customers:
from {{ source('s1', 'customers') }}
```
- **Compile** shows dbt expands `source('s1','customers')` → the real `DEV_DB.CUSTOMER_SCHEMA.CUSTOMERS`.
- Demo: he moved the tables bronze → customer_schema → bronze again, and **only edited `sources.yml`** each time, not the models.
- 💡 Trainer analogy: *"like a parameter file in Informatica."* He explicitly said **"you may get different questions on how to derive the database/schema name dynamically → the answer is sources.yml."** ⭐

---

## 3. ⭐ `packages.yml` + `dbt_utils` (external packages)

dbt has reusable community/official **packages** (libraries of macros). To use one:

1. Create **`packages.yml`** in the project root:
   ```yaml
   packages:
     - package: dbt-labs/dbt_utils
       version: 1.3.0     # version must be valid, else "not a valid semantic version"
   ```
2. Run **`dbt deps`** → installs the package's dependencies.
3. Then you can call its macros (e.g. `dbt_utils.generate_surrogate_key(...)`).

- **Gotcha shown:** calling a `dbt_utils` macro *before* installing → error **"dbt_utils is undefined… install package dependencies."** Fix = `packages.yml` + `dbt deps`.
- 💬 Interview: *"the two YAML files to know — `sources.yml` (dynamic db/schema resolution via `source()`) and `packages.yml` (declare external packages, installed with `dbt deps`)."* ⭐

---

## 4. ⭐ Surrogate keys (ties to your SCD2 hash-key notes!)

- **Surrogate key** = an artificial unique key you generate when a table has **no natural primary key** — especially needed for **SCD Type 2** (to distinguish current vs. historical versions of the same business entity).
- dbt generates it with **`{{ dbt_utils.generate_surrogate_key(['col1','col2',...]) }}`**.
- **Under the hood it uses `MD5`** — the compiled SQL showed an `MD5(...)` hash. 🔗 **This is exactly your `hash_key` pattern from Classes 23–24** (hash the key columns to get a stable unique identifier). The trainer explicitly called back to "hash_key / hash_data" from the SCD2 full-load lessons.
- So: **surrogate key (dbt) = hash_key (your SCD2 notes) = `MD5` of the identifying columns.** Same concept, different wrapper.

---

## 5. Live SQL tangent (orders/customers/payments) — standard SQL recap

Loaded dbt's public demo data (`customers`, `orders`, `payments` from public S3, no integration needed) and wrote a 3-table **join** to find per-customer first order / most-recent order / order count. Pure SQL join practice (useful for interviews, not new Snowflake features). Then wrapped the final query as a **mart model** (`customer_orders_info`) with `config(materialized='table')`.

---

## 6. Previewed for NEXT class

- Continues into Class 36 (macros deep-dive) and Class 37 (incremental + tests).

---

## 7. Cheat-sheet / quick recall

- **Model layers:** seed → **staging** (clean) → **intermediate** (joins + derived) → **mart** (aggregated/business). Each `ref()`s the one below → lineage. ⭐
- **`sources.yml`** + **`source('name','table')`** = declare raw sources once, resolve db/schema **dynamically**, no hardcoding. Trainer-flagged as a likely exam question. ⭐
- **`packages.yml`** + **`dbt deps`** = install external packages (e.g. `dbt_utils`). Error "undefined" = package not installed. ⭐
- **Two key YAML files to name in an interview:** `sources.yml` (dynamic db/schema) and `packages.yml` (external packages).
- **Surrogate key** = artificial unique key (for no-PK tables / SCD2). dbt: `dbt_utils.generate_surrogate_key([...])` → **uses `MD5`** → same as your SCD2 **hash_key**. ⭐
- `config(materialized='table')` overrides default view (recap).

*End of Class 35 notes. Third dbt class: intermediate/mart layers, sources.yml (dynamic db/schema — trainer flagged as a likely interview question), packages.yml + dbt_utils, and surrogate keys (= MD5 hash_key, ties to SCD2). Mostly job skill; the YAML files + surrogate-key/hash connection are the cert-adjacent bits.*
