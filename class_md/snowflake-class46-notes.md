# Class 46 — Search Optimization Service (SOS) vs Clustering, Hybrid Tables Recap & a Cortex/Agents Lab Setup

**Snowflake — Class 46 Notes**
*Sara — SnowPro Core preparation*

> ⭐⭐ **First ~20 minutes are exam-relevant and important:** Search Optimization Service (SOS), finally taught after being promised since Class 30, and the "clustering key vs SOS" decision rule. A short hybrid-tables recap follows.
>
> **Honest labelling:**
> - **§1–§3** (SOS, clustering vs SOS, the demo) are **exam content**.
> - **§4** (hybrid tables recap) is **exam content**, with a caveat on his "master data" example.
> - **§5** (the last ~35 min: an agents lab setup) is **mostly career/AI-features material**, and he did **not finish** it. **Relabelled 9 Nov:** parts of it are exam-relevant, namely the **Git integration** steps (API integration, Git repository object, copying a file from the repo into a stage; one C03 guide lists Git integration as new) and the stage/integration recaps. The agents themselves are not in the C03 guides I found. He said he'd continue "tomorrow" or later.
> - **SOS was taught in under 10 minutes.** He simplified it to "equality = SOS, range = clustering." That is a good rule of thumb but **not the whole truth**; see §2 for what I added from Snowflake's documentation. I've marked those additions clearly.
>
> **Things he said that matter to you (flagged as you asked):**
> - 🐍 **Python sessions start tomorrow**, for people new to Python. He said there is a **separate link**, he'll post it, and it runs **three days**, about **one hour** each. Timing "by 4:30" (I can't tell if that's IST). He'll post it in the batch group.
> - 🗓️ **Monday is a holiday: no session.**
> - 🎪 **Events:** two Snowflake events already happened (**24 Oct** and **31 Oct**). He'll post upcoming events in the **WhatsApp group**. He also said another event may come **in December** and he'll share dates.
> - 🧪 **Trial accounts can't run the Cortex/agents lab** (details in §5). He offered his own account's credentials for practice. **Be careful with that**; see §5.
> - 💬 A student (not clear who) again reminded him about **"profiling"**. Unclear whether he means a CV/profile or something else. Same as last class.

---

## 1. What Search Optimization Service (SOS) is ⭐⭐

- **SOS** is a table-level feature that makes **selective lookups** fast on **large tables**, by building an extra **search access path** that lets Snowflake find which micro-partitions hold a value without scanning them all.
- It gives you **partition pruning** (scan only the required partitions), the same goal as a clustering key but achieved differently.
- He stressed: **the table must be very large**. Both clustering and SOS only make sense on big tables.
- Also useful when you run **the same kind of lookup query frequently**.

## 2. Clustering key vs SOS: the decision rule ⭐⭐

| | **Clustering key** | **Search Optimization Service** |
|---|---|---|
| His rule | **Range** operations (`BETWEEN`, `>`, `<`) | **Equality** (`=`) lookups |
| Typical use | Large scans over a range, e.g. dates | Point lookups, "find this one record" |
| How | Re-organises the data so similar values sit together | Adds a separate search structure over the table |

His one-liner: **"equal to → SOS; range → clustering key."** Both end in partition pruning.

**What I'm adding from Snowflake's documentation** (he did *not* say these. Checked against Snowflake's docs on 9 Nov: substring/regex, VARIANT and geospatial searches **are supported**, and the storage + serverless cost is real, as your lab showed. I could **not** re-confirm the Enterprise-edition requirement on the docs page, so keep that one on your verify list):
- SOS is an **Enterprise Edition (or higher)** feature.
- It has **its own cost**: extra **storage** for the search structure, plus **serverless (background) compute credits** to build and maintain it.
- It supports more than equality: **`IN`**, **substring / `LIKE` / regex** searches, **VARIANT** fields and **geospatial** queries, not just `=`.
- Compare with the other performance tools: **clustering** (organise data), **SOS** (point lookups), **QAS** (offload big scans to serverless compute), **bigger warehouse** (more compute).

## 3. The demo ⭐

**Before SOS:**
- Query with an equality filter on a large table: **69 partitions total**, and a lot of them were scanned. (He said "scanned 16"; the audio is unclear, so don't quote the exact number.)

**Add SOS on one column:**
```sql
ALTER TABLE <table_name> ADD SEARCH OPTIMIZATION ON EQUALITY(<column>);
```
- He described the syntax as "add search optimization on the column name(s)", and said you can list **multiple columns**. The exact clause he typed isn't clear in the audio. **Confirmed in your lab (9 Nov):** `ALTER TABLE … ADD SEARCH OPTIMIZATION ON EQUALITY(col)` runs, and `SHOW TABLES` then shows `search_optimization = ON` with `search_optimization_progress` rising to 100.
- He suspended the warehouse first. The transcript gives no reason; clearing the **local cache** is my inference. ⭐ (Same habit as Class 45.)

**After SOS:**
- Same query: **partitions scanned = 1**. Query Profile showed **"Partitions pruned by search optimization."** 🎯 That is the proof.

**Range query:** `WHERE emp_id BETWEEN 700 AND 812` returned only 2 rows but showed **no partition pruning**, because SOS (as he taught it) is for equality, not ranges.

- Verify in **Query Profile**, or **Query History** (partitions scanned, rows produced, execution time).
- **Your lab (9 Nov):** 20M rows made only **4 micro-partitions**, so pruning could not show a difference (`EXPLAIN` showed `partitionsTotal=4, partitionsAssigned=4`). The SOS structure took **67.9 MB for a 126 MB table**, which is a real storage cost.
- He noted **"Analyze with Cortex"** is **disabled on the free trial**. (The sentence is garbled, so treat that detail as uncertain.)

## 4. Hybrid tables recap ⭐ (ties to Class 29)

He demonstrated this using Cortex Code (his AI assistant; he calls it "Coco/Cocoa") to generate the syntax:

- Syntax uses `CREATE HYBRID TABLE`.
- ⭐ **A PRIMARY KEY is mandatory** on a hybrid table. Creating one without it gives the error "primary key is required."
- ⭐ **Hybrid tables ENFORCE the primary key**: duplicates and NULLs are rejected. For a normal table, a PK is only informational (Class 38).
- To check for existing hybrid tables, he queried the schema tables view filtering on `IS_HYBRID = 'YES'`. None existed.
- ⚠️ **On the trial account the create failed**, and he said hybrid tables may need a credit card / paid account. I can't confirm the exact reason from the audio. Your handover says never add billing, so **don't try to force this**.
- **Use case he gave:** small, stable "master data" such as a hospital's departments (cardiology, etc.) where you don't want NULLs or duplicates. He called them **transactional tables**.
- ⚠️ **Careful with the exam framing:** hybrid tables are designed for **transactional (OLTP) workloads**: fast single-row reads/writes and **enforced constraints**. The "master/dimension data" example illustrates the enforcement, but the **defining exam point is "transactional + enforced PK/unique/FK."**

## 5. Cortex Code and a Snowflake Intelligence / Agents lab (mixed: Git integration = exam-relevant; agents = career)

- He attended a Snowflake event on **building agents "from zero to hero"**. He walked through its **setup script** live. He did **not finish**; he'll show more later, or you can try the lab yourself.
- You find these labs on Snowflake's developer **guides / quickstarts** pages. Your earlier link (Microsoft Copilot Studio + Cortex Agents) is one of that family, but I **still can't confirm** it's the same lab.
- **Trial limits:** he said the lab needs **Cortex enabled** and doesn't work on a plain trial. His first attempt to make a new trial through a link didn't work. He later showed it working in **his own account**.
- ⚠️ **He offered to share his account username/password so students can practise.** I'm not recording any credentials. **Think carefully before logging into someone else's shared account**; you don't control it, others use it at the same time, and anything you run is visible there. Also do not paste any credentials into notes or a public repo (your repo is public).

What the setup script did (useful recaps of earlier topics):
- Created a **role**, granted it `CREATE WAREHOUSE`, `CREATE DATABASE`, `CREATE INTEGRATION`, and a new **`CREATE AGENT`** privilege on a schema; created a database and a schema called `agents`.
- Used a **session variable** holding `CURRENT_USER()` so the role can be granted to whoever runs the script.
- Created **file formats**, an **external stage** over a **public S3 bucket** and **internal stages**. ⭐ Recap: **a public bucket needs no storage integration; a private bucket does** (Classes 11–12).
- Previewed a CSV straight from the stage (query the stage with a file format), then `COPY INTO` tables. Data was small: **23 rows, 4 columns** per file.
- ⭐ **Git integration (exam-relevant):** created an **API integration** to GitHub (lets Snowflake call GitHub) and a **Git repository** object (behaves like a stage over the repo), then copied a YAML file from the repo into an internal stage. The exact `COPY` syntax is my approximation of garbled audio.
- Created a **notification integration** and a **stored procedure** to send email (recap of procedures).
- Distinguished stages: a stage **with a URL** is **external**; one **without a URL** is **internal** (`SHOW STAGES`).

## 6. Previewed / still owed

- He'll show the rest of the agents lab "tomorrow, timing to be confirmed."
- **Python sessions** start tomorrow (for newcomers, separate link).
- **QAS** is still to come, and **procedures and functions** (a week, from Class 45).
- **Monday: no class.**

## 7. Cheat-sheet / quick recall

- **Clustering key** for **range** filters; **SOS** for **equality** lookups; both need **large tables** and give **partition pruning**. ⭐⭐
- SOS syntax: `ALTER TABLE t ADD SEARCH OPTIMIZATION ...` (his demo: one column, then partitions scanned fell to 1). ⭐
- Verify with Query Profile: partitions scanned vs total, "pruned by search optimization."
- *From docs, not class:* SOS = Enterprise+, costs storage + serverless credits, also helps `IN`, `LIKE`/substring, VARIANT, geospatial. ⭐ (verify)
- **Hybrid table:** PK **mandatory** and **enforced**; built for **transactional** workloads. Normal-table PK is not enforced. ⭐⭐
- **Public** S3 stage needs no storage integration; **private** does. ⭐
- Stage with URL = external; no URL = internal.
- Benchmark tip (my inference): suspend the warehouse first to clear local cache, or set `USE_CACHED_RESULT = FALSE`.
- ⭐ Git integration: API integration + Git repository object, then copy files from the repo into a stage (one C03 guide lists it as new).
- Trial accounts can't run the Cortex agents lab. **Don't use shared credentials casually, and never commit them.**

*End of Class 46 notes. Short exam content: SOS finally taught (equality vs range, demo down to 1 partition), the clustering-vs-SOS rule, hybrid tables recap. The rest was a Cortex/agents lab setup that he did not finish, plus logistics (Python sessions, Monday holiday, events).*
