# Class 41 — dbt: Variables, Ephemeral in Use, Analyses & Tags (dbt series wrapping up)

**Snowflake — Class 41 Notes**
*Sara — SnowPro Core preparation*

> 🛑 **Honest labeling.** All **dbt** — variables (`var()` / `--vars`), ephemeral models in use, analyses, and tags. **Zero SnowPro Core exam value**; interview/job material only.
>
> **🟢 Good news at the end:** the trainer said *"tomorrow we need to talk about a few topics with respect to **Snowflake**"*, so the dbt series (Classes 33–41) looks like it's ending. **SOS is still untaught**; watch for it next.
>
> **Event note (you asked me to flag these):** he attended the Snowflake event last Saturday and will **explain it "most probably this Saturday"** in an optional session; he'll share timings.

---

## 1. Variables — avoid hardcoding filter values (interview)

- Declare in **`dbt_project.yml`** under `vars:` (convention: `v_` prefix):
  ```yaml
  vars:
    v_deptno: 30
    v_job: 'CLERK'
  ```
- Use in a model with the **`var()`** macro:
  ```sql
  select * from {{ source('s1','emp') }}
  where job = '{{ var("v_job") }}' and deptno = {{ var("v_deptno") }}
  ```
  ⚠️ String values need **single quotes around the `{{ }}`** (a compile gotcha shown live).
- **Override at run time** by passing JSON with **`--vars`**:
  ```
  dbt run --select t_orders_info --vars '{"status": "return_pending"}'
  ```
- Demo: an orders model filtered by `status`. Default was `completed`; passing `--vars` switched it to `return_pending` without editing the SQL.
- (He hit a *deprecation* warning on one older way of passing variables. The `vars:` block in `dbt_project.yml` + `--vars` is the current way.)

## 2. Ephemeral models in use (completes Class 40)

- Two ephemeral models (`eph_customers`, `eph_orders`) referenced from a final model with `ref()`.
- **Compiled SQL shows dbt inlining each ephemeral model as a CTE (`WITH` clause)**, and **no ephemeral object exists in Snowflake**. Only the final model (materialized as a table) is created.
- He listed **4 materializations: view, table, incremental, ephemeral.**

## 3. Analyses folder (interview)

- `analyses/` holds **ad-hoc / validation SQL** (e.g. "top 5 most expensive claims by specialty", "in-network vs out-of-network spend").
- **Analyses never create objects.** `dbt compile` just renders them (resolves `ref()` → `DEV_DB.SILVER.<model>`).
- Typical use: standard queries the **business / QA team** run after a deployment to check results.
- Compiled output lands in the **`target/`** folder: `target/compiled/…` (compiled SQL) vs `target/run/…` (what actually executed).

## 4. Tags — run groups of models (interview)

- Add tags in a model: `{{ config(tags=['finance','reporting']) }}`.
- Or tag a **whole folder** in `dbt_project.yml` (indentation matters, which caused the error he hit live):
  ```yaml
  models:
    my_project:
      staging:
        +tags: ['stg']
      intermediate:
        +tags: ['int']
      marts:
        +tags: ['marts']
  ```
- Run by tag:
  ```
  dbt run --select tag:finance      # ran 2 models
  dbt run --select tag:int          # all intermediate models
  ```
- 💬 Interview: *"Tags let you run a slice of the project, like all finance models or all staging models, without listing them one by one."*

## 5. Previewed for NEXT class

- **Back to Snowflake topics** 🟢 (dbt series ending).
- Optional **Saturday session** on the Snowflake (AI) event he attended.

## 6. Cheat-sheet / quick recall

- **Variables:** declare in `dbt_project.yml` `vars:` → use `{{ var('name') }}` → override with `--vars '{"name": "value"}'` (JSON).
- **Ephemeral** = no object, inlined as a CTE; materializations = view / table / incremental / ephemeral.
- **Analyses** = ad-hoc validation SQL, never materialized; compile renders them into `target/compiled`.
- **Tags:** `config(tags=[...])` or `+tags` per folder in `dbt_project.yml` → `dbt run --select tag:<name>`.
- 🛑 All dbt → **not on SnowPro Core.**

*End of Class 41 notes. dbt variables, ephemeral in use, analyses and tags. No exam content. The trainer announced a return to Snowflake topics next class; SOS still outstanding.*
