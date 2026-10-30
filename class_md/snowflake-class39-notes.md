# Class 39 — dbt Snapshots (SCD Type 2) + dbt Core (CLI) Setup

**Snowflake — Class 39 Notes**
*Sara — SnowPro Core preparation*

> 🟡 **Honest labeling.** dbt class, continuing the arc. Two topics:
> 1. **Snapshots** = SCD Type 2 in dbt (the history-tracking the trainer kept promising). **Cert-adjacent** because it ties directly to your SCD2 / `hash_key` notes (Classes 23–24) — snapshots use an **MD5** surrogate key and `valid_from`/`valid_to` columns, exactly your Type-2 pattern.
> 2. **dbt Core (CLI)** setup — the free, installed-locally version vs. dbt Cloud (browser). **Job skill, not exam.**
>
> **No SOS, no new Snowflake-exam feature.** But snapshots are worth understanding because SCD2 itself is a real concept you already know.

---

## 0. Context

Continues from tests (Class 38). First half = **snapshots** (SCD2). Second half = installing **dbt Core** locally (Anaconda + `dbt-core` + `dbt-snowflake`) and running the same project from the command line / VS Code.

---

## 1. ⭐ Snapshots = SCD Type 2 in dbt (ties to your hash_key notes)

### The problem (recap)
A source table only shows the **current** value of a row. If a ticket's status goes `new → in_progress → complete → closed`, the base table only shows `closed` — **history is lost.** SCD Type 2 keeps every version. In dbt, **snapshots** do this automatically.

### What a snapshot produces
Run a snapshot and dbt builds a table with your original columns **plus**:
| Column | Meaning |
|---|---|
| **`dbt_scd_id`** | a unique surrogate key = **MD5 hash** of (key + checked cols + timestamp) — *same idea as your `hash_key`* 🔗 |
| **`dbt_updated_at`** | when dbt recorded this version |
| **`dbt_valid_from`** | when this version became current |
| **`dbt_valid_to`** | when it stopped being current — **NULL = the latest/current record** ⭐ |

> **`dbt_valid_to IS NULL` = current row; populated = historical row.** This is *exactly* the `is_current` / `end_date IS NULL` logic from your Class 23–24 SCD2 notes.

### Defining a snapshot
Lives in the **`snapshots/`** folder (NOT `models/` — a gotcha shown live: putting it in `models/` built a plain view instead). Uses the `{% snapshot %}` block + `config`:
```sql
{% snapshot t_ticket_status %}
{{ config(
     target_database='DEV_DB',
     target_schema='SILVER',
     unique_key='id',
     strategy='check',
     check_cols=['status']
) }}
select * from {{ source('s1','ticket_status') }}
{% endsnapshot %}
```
Run it:
```
dbt snapshot
```

### The two snapshot strategies ⭐ (interview)
| Strategy | How it detects a change |
|---|---|
| **`check`** | compares the **`check_cols`** you list — if any changed value differs, it's a new version. (Used in the demo: `check_cols=['status']`, or in the healthcare project `['plan_id','termination_date','is_active']`.) |
| **`timestamp`** | uses an **`updated_at` column** — if the timestamp is newer, it's a new version. (Cleaner when you trust a reliable last-modified timestamp.) |

### Behaviour demonstrated
- First `dbt snapshot` = loads current rows (all `valid_to = NULL`).
- Change a status in source → `dbt snapshot` again → old row gets `valid_to` filled in, **new row inserted** with `valid_to = NULL`. Base table shows 3 rows; snapshot shows 6 (full history).
- Under the hood dbt uses a **temp table + MERGE** (same mechanics as the manual SCD2 you did in Classes 23–24).

💬 **Interview soundbite:** *"dbt snapshots implement SCD Type 2 — they track history with valid_from/valid_to and an MD5 surrogate key. The `check` strategy watches specific columns for changes; the `timestamp` strategy uses a last-updated column. valid_to IS NULL marks the current record."*

---

## 2. dbt Core (CLI) vs dbt Cloud (job skill — NOT exam) — brief

Same project, two ways to run it:
- **dbt Cloud** = browser IDE, nothing to install (what we've been using). Paid after trial.
- **dbt Core** = free, open-source **CLI**, installed locally. What many companies use in production (the trainer's team switched to Core for cost).

### dbt Core setup steps shown
1. **Install Anaconda** (Python environment manager).
2. Create an isolated env: `conda create -n dbt_project_7am` → `conda activate dbt_project_7am`.
3. Install packages: **`pip install dbt-core`** then **`pip install dbt-snowflake`** (the Snowflake adapter/plugin — dbt Core needs the right **adapter** per warehouse).
4. **`dbt init <project>`** → prompts for the connection (snowflake account, user, password, role, warehouse, database, schema, threads) → scaffolds the project folders locally.
5. **`dbt debug`** → validates the connection ("all checks passed").
6. **`code .`** → opens the project in **VS Code** to edit models.
7. Then the same commands work: `dbt run`, `dbt seed`, `dbt snapshot`, `dbt test`, `dbt build`.

> **Key point:** *"There's no difference in what you build — Cloud vs Core differ only in that Core you install (dbt-core + dbt-snowflake adapter) and run from the CLI/VS Code; Cloud is hosted."* Used a separate schema `SILVER_CORE` to keep Core's output distinct.

---

## 3. Previewed for NEXT class

- Trainer said after dbt, **"one or two more sessions"** then they'll move on. Offered to help individually with dbt Core install issues.
- Still **no SOS** scheduled (outstanding since Class 30).

---

## 4. Cheat-sheet / quick recall

- **Snapshot = SCD Type 2 in dbt.** Lives in `snapshots/`, run with **`dbt snapshot`**. Adds `dbt_scd_id` (MD5 surrogate), `dbt_valid_from`, `dbt_valid_to`, `dbt_updated_at`. **`valid_to IS NULL` = current row.** ⭐
- **Two strategies:** `check` (watch listed `check_cols`) vs `timestamp` (watch an updated-at column). ⭐
- Snapshot = your Class 23–24 **SCD2 hash_key + is_current/end_date** pattern, automated (temp table + MERGE under the hood). 🔗
- **dbt Core** = free CLI: `pip install dbt-core` + **`dbt-snowflake`** adapter → `dbt init` → `dbt debug` → `code .` (VS Code). Same commands as Cloud. **Job skill, not exam.**
- **dbt command set:** `run` (models), `seed` (CSVs), `snapshot` (SCD2), `test` (validations), `build` (all together).

*End of Class 39 notes. dbt snapshots (SCD2 — valid_from/valid_to + MD5 scd_id, check vs timestamp strategy; ties to your hash_key notes) and dbt Core CLI setup (install dbt-core + dbt-snowflake). Snapshot/SCD2 concept is the cert-adjacent bit; Core is job skill.*
