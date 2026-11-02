# Class 40 — dbt Core: profiles.yml, docs, hooks & Ephemeral Materialization

**Snowflake — Class 40 Notes**
*Sara — SnowPro Core preparation*

> 🛑 **Honest labeling.** Entirely **dbt Core** (the CLI version). Topics: `profiles.yml` / `dbt_project.yml`, `dbt docs`, pre/post **hooks**, **ephemeral** materialization, cloning the repo. **~Zero SnowPro Core exam value** — all dbt mechanics. Good **job skill** only.
>
> The one genuinely useful *concept* add: **ephemeral materialization** completes your view/table/incremental/**ephemeral** picture. Everything else is dbt-Core plumbing.
>
> **Still no SOS, no new Snowflake-exam topic.** Course has now been on dbt for Classes 33–40 (8 classes). Trainer said *"one or two more sessions"* earlier.

---

## 0. Context

Continues Class 39's dbt Core setup — running the same project from the CLI / VS Code, plus a few dbt features not seen in Cloud.

---

## 1. The two dbt Core config files (job knowledge)

When you run **`dbt debug`** (validates your setup), dbt reads two files:

| File | Location | Contains |
|---|---|---|
| **`profiles.yml`** | `~/.dbt/` (user home, e.g. `C:\Users\<you>\.dbt\`) — **outside the project** | the **connection** details: account, user, password, role, warehouse, database, schema. *(This is why it's not in the Git repo — secrets stay local.)* |
| **`dbt_project.yml`** | **project root** | project name, folder **paths** (models/seeds/macros/snapshots…), default materialization, hooks |

💬 Interview: *"`profiles.yml` holds the connection/credentials and lives in `~/.dbt` outside the repo; `dbt_project.yml` is the in-repo project config — paths, name, default materialization. `dbt debug` validates both."*

---

## 2. `dbt docs` — auto-generated project documentation + lineage ⭐ (job-useful)

```
dbt docs generate     # build the docs
dbt docs serve        # open the docs UI in a browser
```
- Produces a browsable site: every model's **code, compiled SQL, dependencies ("depends on" / "referenced by"), and a full lineage graph.**
- Great for understanding an unfamiliar project / debugging / onboarding (the real value of lineage at scale, reinforced).
- Needs `dbt_utils` → requires `packages.yml` + **`dbt deps`** first (the "dbt_utils is undefined" error again = package not installed).
- You can **view/share the URL** but the generated docs **can't be uploaded to Confluence** etc. — refer people to the served link.
- Confirmed again: `generate_surrogate_key` **uses `MD5`** under the hood; `safe_divide` avoids divide-by-zero.

---

## 3. Pre-hooks / Post-hooks ⭐ (useful concept — audit/logging pattern)

**Hooks** = SQL that dbt runs **before** (`pre-hook`) or **after** (`post-hook`) a model builds. Common use: **audit logging** (track when each model started/finished).

Demo:
1. Created an audit table: `BRONZE.audit_log (audit_type, model_name, timestamp DEFAULT current_timestamp())`.
2. In `dbt_project.yml`, under `models:`, added:
   - **pre-hook** → insert a `'start'` row with the model name
   - **post-hook** → insert an `'end'` row
   - model name grabbed via **`{{ this }}`** (same syntax as incremental models).
3. Run `dbt build` → audit table fills with start/end timestamps per model → **subtract to get each model's run duration.**

💬 Interview: *"Pre/post-hooks run SQL before/after a model — I used them to write start/end rows to an audit table so I could measure each model's execution time."*

---

## 4. ⭐ Ephemeral materialization (completes the materialization set)

You now know **all four** dbt materializations:

| Materialization | Builds in Snowflake? | Use |
|---|---|---|
| **view** (default) | ✅ a view | lightweight, always fresh |
| **table** | ✅ a table | fast reads, expensive transforms |
| **incremental** | ✅ a table (merge new rows) | huge tables |
| **ephemeral** ⭐ NEW | ❌ **no object created** | reusable SQL inlined as a **CTE** into downstream models |

- Set with `{{ config(materialized='ephemeral') }}`.
- **It creates NOTHING in the database.** Instead, when another model `ref()`s it, dbt **inlines its SQL as a CTE** (`WITH` clause) into that model.
- **Use case shown:** the same `SELECT` (e.g. a cleaned customers/orders pull) is reused across 100 models → make it **ephemeral** so you write the logic once and reference it, without creating 100 intermediate objects. Naming convention: prefix `eph_`.
- 💬 Interview: *"Ephemeral models aren't materialized as objects — dbt inlines them as CTEs in downstream models. Good for reusable logic you don't want cluttering the warehouse as physical tables/views."*

---

## 5. Cloning the repo (job knowledge)

- Reinforced the Git safety net: *"even if your dbt trial expires, once the code is in GitHub you just **clone the repo** and keep working."*
- `git clone <repo-url>` into your dbt Core folder → full project structure locally → open with `code .` (VS Code).
- Can also **Download ZIP** from GitHub.

---

## 6. Previewed for NEXT class

- Continues referencing the ephemeral models in a final model (cut off at end).
- **SOS still not scheduled.**

---

## 7. Cheat-sheet / quick recall

- **`profiles.yml`** = connection/creds, in `~/.dbt` (outside repo). **`dbt_project.yml`** = project config (paths, name, default materialization, hooks). `dbt debug` checks both. 
- **`dbt docs generate` + `dbt docs serve`** = browsable docs + lineage (needs `dbt deps` for `dbt_utils`).
- **Hooks:** `pre-hook` (before model) / `post-hook` (after) → e.g. audit-log start/end timestamps; model name via `{{ this }}`. ⭐
- **4 materializations: view (default), table, incremental, ephemeral.** **Ephemeral = no object, inlined as a CTE** into downstream models. ⭐
- Everything here is **dbt job skill — NOT on the SnowPro Core exam.** 🛑

*End of Class 40 notes. All dbt Core: config files, docs/lineage, pre/post hooks (audit logging), and ephemeral materialization (the 4th materialization — no object, inlined as CTE). Zero exam value; good interview/job material. SOS still outstanding.*
