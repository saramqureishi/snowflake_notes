# Class 34 — dbt Part 2: Seeds & Staging Models (⚠️ NOT SnowPro Core exam material)

**Snowflake — Class 34 Notes**
*Sara — SnowPro Core preparation*

> 🛑 **Read this first — honest labeling (your rule: cert-only, don't pad).**
>
> **Class 34 is a second full dbt class** — a direct continuation of Class 33. It covers dbt **seeds** (load CSVs → tables) and **staging models** (transform with `ref()` + CTEs). **Almost none of it is on the SnowPro Core exam.** dbt is a third-party transformation tool; building seeds/models is dbt-specific skill, not Snowflake-exam content.
>
> **SOS (Search Optimization Service) was NOT covered** — not even mentioned this class. Still pending after Classes 30→31→32→33→34.
>
> **What to do with this for the cert:** basically nothing. Skim the "Snowflake bits that got name-dropped" box — all recaps — and move on. Kept short on purpose; there's no cert value to pad. (Great job material, just not this exam.)

---

## 0. Context (not exam)

Same ELT project as Class 33: **bronze (raw) → silver (transformed) → gold (reporting)**, with dbt doing the transformations and GitHub storing the code. This class loads raw healthcare CSVs into silver as tables (seeds), then builds **staging models** that clean/derive columns on top of them.

---

## 1. Snowflake bits that got name-dropped (all recaps — the only cert-adjacent content)

- **`dbt seed` creates TRANSIENT tables** ⭐ (the one nice Snowflake tie-in). When dbt loaded the 8 CSVs, `QUERY_HISTORY` showed it issuing `CREATE TRANSIENT TABLE … ` + `INSERT`. Recall (Class 26): **transient tables = no fail-safe, max 1-day Time Travel → cheaper storage**, sensible for reloadable raw data. ✅ already known.
- **`INFORMATION_SCHEMA`/`QUERY_HISTORY`** — used again to inspect the `CREATE`/`INSERT` statements dbt generates under the hood. ✅ already known.
- **Data types / `CAST`** — staging models `CAST` strings to DATE/TIMESTAMP/DECIMAL. Standard SQL; nothing Snowflake-specific.
- **PII / PHI** — reinforced with the healthcare data (member names, DOB, SSN; diagnosis/procedure codes = PHI). *Cert link:* the business reason behind **secure views / dynamic data masking / column-level security** — but no Snowflake masking feature was actually taught here.

> **That's the complete list of cert-touching content in Class 34.** Everything below is dbt reference — job knowledge, not exam.

---

## 2. dbt reference (job knowledge — NOT exam) — brief

### Seeds
- **`dbt seed`** loads **CSV** files (placed in the `seeds/` folder) into tables in the target schema. (JSON/Parquet are **not** supported by seeds — different approach needed.)
- `dbt seed` = load all; `dbt seed --select <file>.csv` = load one.
- dbt auto-infers column names/types and creates the table (as **transient** in Snowflake) + inserts rows.
- Demo dataset: a healthcare model — `members` (patients), `providers` (hospitals/clinics/pharmacies), `claims`, `plans` (insurance).

### Staging models + `ref()`
- A **model** = a `SELECT` with transformation logic; running it builds an object (default **view**) in the target.
- **`{{ ref('<object>') }}`** macro = the way one model references another object (a seed or model) instead of hardcoding `schema.table`. dbt resolves it to the real `silver.<name>` at compile time and builds a dependency graph.
- **Compile** button shows the actual SQL dbt will send (the `ref()` expands to `silver.raw_members`, etc.).
- **Lineage** tab shows source → target visually (seed → staging model).
- Example staging transforms shown: derive `full_name` (first || ' ' || last), `is_active` (TRUE when termination_date IS NULL), `CAST` dates/decimals, `UPPER()` normalization, and boolean flags (`is_paid`, `is_denied`, `is_inpatient`, `in_network`).
- **`dbt run --select <model>`** builds one model; `dbt run` builds all.

### Project folder convention (teased, explained next class)
- Inside `models/`: **staging**, **intermediate**, **mart** folders. Staging = light cleanup on raw; intermediate/mart = business logic (details deferred to the next session).

---

## 3. Domain tangent (not Snowflake, not exam)

A long insurance explainer: **in-network** (hospital tied to your insurer → insurer settles directly, you pay little) vs **out-of-network** (not tied → you pay upfront, claim reimbursement later). Useful for understanding the sample data; **zero exam relevance.**

---

## 4. Previewed for NEXT class

- Why the **staging / intermediate / mart** folder split exists; the "advantage of dbt" (non-exam).
- *(No session the following day — holiday.)*
- **SOS still owed** — not scheduled explicitly, but it remains the big outstanding Snowflake topic.

---

## 5. Cheat-sheet / quick recall (cert-only)

- **Class 34 added NO new SnowPro Core material.** It's dbt Part 2 (seeds + staging models). ⚠️
- **Only real Snowflake tie-in:** `dbt seed` builds **TRANSIENT** tables (recall: no fail-safe, ≤1-day Time Travel, cheaper). ⭐
- **dbt seeds = CSV→table (CSV only).** `ref()` = reference another dbt object; **compile** shows real SQL; **lineage** shows dependencies.
- PII/PHI reinforced → rationale for **secure views / masking** (no feature taught here).
- **SOS still not covered** — deferred/omitted again.
- **If tired: skip this class for the cert.** Spend energy on Class 32 (QAS/pruning/clustering) and the pending Iceberg + Dynamic Tables Q&A.

*End of Class 34 notes. Honest verdict: dbt Part 2 (seeds + staging models), no net-new SnowPro Core content; SOS still pending. Kept short per the don't-pad / cert-only rule.*
