# Class 33 — dbt + Git/GitHub Workflow (⚠️ NOT SnowPro Core exam material)

**Snowflake — Class 33 Notes**
*Sara — SnowPro Core preparation*

> 🛑 **Read this first — honest labeling (your rule: cert-only, don't pad).**
>
> **This entire class is about dbt (data build tool) and the Git/GitHub pull-request workflow. Almost none of it is on the SnowPro Core exam.** dbt is a **third-party transformation tool**; Git/GitHub branching and PRs are **general engineering workflow** — neither is tested by SnowPro Core.
>
> **SOS (Search Optimization Service) was promised again and was NOT covered** — pushed once more to "Monday's session." So **SOS is still pending** (watch for it in a later class).
>
> **What to actually do with this class for the cert:** basically nothing. Skim the "Snowflake concepts that got name-dropped" box below (all recaps of things you already know) and move on. I'm deliberately keeping these notes short — there's no cert value to pad. The dbt material is useful for a **job**, just not for this **exam**.

---

## 0. Why this class exists (context, not exam)

The instructor is walking the class through a real-world **ELT project shape**: land raw data in a **bronze** layer in Snowflake, use **dbt** to transform it into **silver** (and later **gold** for reporting), with the dbt code version-controlled in **GitHub**. It's good career context, but it's **outside SnowPro Core scope.**

---

## 1. Snowflake concepts that got name-dropped (all recaps — the only cert-adjacent bits)

These came up only as analogies while explaining dbt. You already have full notes on them; nothing new:

- **SCD Type 2** — invoked to explain dbt "snapshots." Recall (from Classes 23–24): keep current **and** historical rows; identify the current row by `is_current = TRUE` **or** `end_date IS NULL`; expire old / insert new with start/end dates. ✅ already solid.
- **Time Travel** — mentioned as the idea behind "snapshots" (seeing history). Recall (Class 25): `AT`/`BEFORE`, retention, `UNDROP`, fail-safe. ✅ already solid.
- **Constraints** — primary key, unique, NOT NULL came up to explain dbt "tests." Recall (Class 29): on normal Snowflake tables **only NOT NULL is enforced**; PK/UNIQUE are **not** enforced (metadata only). ✅ already solid.
- **PII / PHI (data sensitivity)** — PII = personal info (name, DOB, card numbers); PHI = protected health info (diagnoses, etc.); plus financial data (balances, loan amounts). Don't expose sensitive data to unauthorized users. *Cert link:* this is the business reason behind **secure views / dynamic data masking / column-level security** — worth a one-line mental note, but the class didn't teach any Snowflake masking feature here.
- **`INFORMATION_SCHEMA.QUERY_HISTORY`** — used to confirm what SQL dbt generated (it showed dbt issuing a `CREATE VIEW …`). Recall: query history is a table function that lists executed statements. ✅ already known.
- **Storage Integration analogy** — the instructor compared the dbt↔GitHub SSH-key handshake to the **Snowflake↔AWS storage integration** (external ID + IAM role ARN + allowed locations). That Snowflake integration pattern *is* exam-relevant (you covered it for external stages/Iceberg, Classes 8/27) — but nothing new was taught; it was just an analogy.

> **That's the complete list of cert-touching content in Class 33.** Everything else below is dbt/Git reference — keep for your job, ignore for the exam.

---

## 2. dbt reference (job knowledge — NOT exam) — kept brief on purpose

**What dbt is:** a **transformation ("T" in ELT) tool.** Source = Snowflake, target = Snowflake. You write SQL `SELECT`s; dbt builds the target objects. Two flavors: **dbt Cloud** (browser UI, paid after trial) and **dbt Core** (free CLI). Loose parallel to Snowflake's **Snowsight (UI) vs SnowSQL (CLI)**.

**dbt component glossary (naming only — the ideas are things you already know):**

| dbt term | What it really is |
|---|---|
| **Model** | A `SELECT` with your transformation logic. Running it builds a table/view in the target. |
| **Materialization** | The *type* of object a model creates in the target. **Default = view.** (Also table, incremental, etc.) |
| **Macro** | A reusable function (dbt's word for "function"). |
| **Seed** | Load a small CSV into a table (dbt's equivalent of `COPY INTO` for static reference data). |
| **Snapshot** | Implements **SCD Type 2** (history tracking). |
| **Analysis** | Ad-hoc SQL for business reporting/trends; not materialized. |
| **Test** | Data-quality checks — built-ins (unique, not_null, PK/relationships) **plus custom business rules** (e.g. discharge_date ≥ admission_date). |
| **Documentation (dbt docs)** | Auto-generates project docs (models, sources, lineage) — a "knowledge book." |
| **`dbt run`** | Executes models only (builds the objects). |
| **`dbt build`** | Executes models **and** tests (and other node types) together. |
| **`dbt run --select <model>`** | Run one specific model; no `--select` = run all models. |

**Gotcha shown live:** a `dbt run` **failed** because dbt looked for the source table in the **target (silver) schema** — the model's `FROM` needed to point at the **bronze** source. Lesson: dbt resolves unqualified names against the **configured target schema** by default.

---

## 3. Git / GitHub workflow (general engineering — NOT exam) — brief

The back third was a standard Git walkthrough:
- Create GitHub account → **repository** ("a common folder to store code").
- Connect dbt ↔ GitHub via an **SSH key** (generate in dbt, paste into GitHub → Settings → SSH keys).
- **Initialize dbt project** → folders appear (models, macros, seeds, snapshots, tests, YML).
- **Branches:** `main` + feature branches (e.g. one per batch); **checkout** = switch branch.
- **Commit** changes → **compare & pull request (PR)** → reviewer approves → **merge to main.**
- Point made: `main` is the shared source of truth; everyone branches off it and merges back via PR.

*(You already know this workflow from your own notes repo + PRs — nothing Snowflake-specific.)*

---

## 4. Homework the instructor set (for the live cohort)

Not cert work, but noting it so you know what the class was asked to do: create a fresh Snowflake trial, set up the dbt→GitHub repo, and build the simple `emp_info` model end-to-end. Optional for you; zero exam value.

---

## 5. Previewed for NEXT class

- *"Monday we'll talk about the other pending things in Snowflake"* → **this is where SOS should finally appear.** ⚠️ Still pending after three deferrals (Classes 30→31→32→33).
- More dbt practice (non-exam).

---

## 6. Cheat-sheet / quick recall (cert-only)

- **Class 33 added NO new SnowPro Core material.** It's a dbt + Git/GitHub class. ⚠️
- **dbt = third-party transformation tool; NOT on the exam.** Git/GitHub PRs = general workflow; NOT on the exam.
- The only Snowflake bits were **recaps**: SCD Type 2, Time Travel, constraint enforcement (NOT NULL enforced; PK/UNIQUE not), PII/PHI → the rationale for secure views/masking, `QUERY_HISTORY`, and the storage-integration analogy.
- **SOS (Search Optimization Service) is STILL not taught** — deferred again. Expect it next.
- **If you're tired: skip re-reading this class.** Spend the energy on QAS/pruning/clustering (Class 32) and the pending Iceberg + Dynamic Tables Q&A instead.

*End of Class 33 notes. Honest verdict: a dbt/Git workflow class with no net-new SnowPro Core content; SOS deferred again. Kept intentionally short per the "don't pad / cert-only" rule.*
