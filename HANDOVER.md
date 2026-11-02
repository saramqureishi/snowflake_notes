# HANDOVER — Sara's Snowflake / SnowPro Core Training (read this first)

> **For the next AI assistant:** this file is the full context for continuing Sara's training. Read all of it before replying. Last updated: after **Class 42** (late Oct 2026).

---

## 1. Who Sara is and how to work with her

- **Sara Qureishi**, international student in **London (UK time; India/trainer is +5:30)**, preparing for the **SnowPro Core exam in December 2026** and applying for data engineering jobs.
- Often tired and stretched. **Explain simply and memorably. She learns by doing**, with plain-English "what + why" inline, not by reading afterwards.
- **Be honest:** label light / recap / non-exam classes clearly and don't pad. Tell her if she seems to be copy-pasting without understanding. Stay on Snowflake / cert / job topics.
- **Verify, don't assume.** She often says "u sure? cross check", so check transcripts, files or query output before claiming something. (A previous assistant over-labeled dbt remarks as "exam" signals and had to correct it; see §7.)
- **Hands-on format she wants:** give SQL in **batches of 3–4 statements** (Run All in Snowsight), and **end each batch with a check SELECT**, since Snowsight only shows the last result. Run statements that are expected to error, or are sensitive data changes, **on their own**. Explain each statement (what + why + exam point). She pastes the output back.
- After each class's hands-on: **remind her to write her own notebook notes**, and give a **certification summary** (exam-focused bullets).

## 2. The per-class workflow (carry forward exactly)

1. She pastes a **Google Drive link** to the class recording.
2. **Download** (`gdown`) → **check it isn't a duplicate** (`md5sum` against recent recordings; the course once posted the same video twice) → **extract audio** (`ffmpeg` to 16 kHz mono WAV) → **transcribe** (`faster-whisper`, model `base`, `int8`, **force `language="en"`**, run in the foreground).
3. Write **detailed, honest markdown notes** in `class_md/snowflake-classNN-notes.md` (style below).
4. Build the styled per-class docx + **rebuild the master doc** with `build_master_doc.py`.
5. Commit + push. **Never commit directly to `main`**; use a branch + PR.
6. Exam-relevant hands-on → cert summary → notebook reminder.

**Notes style:** `# Class NN — Topic`, `**Snowflake — Class NN Notes**`, a `>` honest-labeling callout at the top (what's exam vs job vs not covered), numbered `##` sections, ⭐ for exam weight, "Previewed for NEXT class", and a "Cheat-sheet / quick recall" section at the end. Flag anything the trainer says about **certification, events, interviews or scheduling**.

**Toolchain notes (sandbox):** the tools reset every session. In Kiro's sandbox, `/root/.local` and `/usr/local/bin` were read-only, so it used a venv at `./venv` (`pip install gdown faster-whisper python-docx`) and a static ffmpeg build (johnvansickle.com) in `./bin/`. Adapt to whatever your environment allows.

**Build commands:**
```bash
python build_master_doc.py --class-md class_md/snowflake-classNN-notes.md --n NN --repo-dir .
# --n is the LATEST class number; it also names the per-class docx.
# For a per-class docx of an earlier class:
python -c "from build_master_doc import build_per_class_docx as b; b('class_md/snowflake-class35-notes.md',35,'class_md')"
```

## 3. Where everything is

| Thing | Location |
|---|---|
| **Latest master notes (21–42)** | `Snowflake-Classes-21-42-Master-Notes.docx` (older `21-30`…`21-41` masters are superseded snapshots) |
| Classes 1–21 notes | `Snowflake-Classes-1-21-Complete-Notes (1).docx` |
| Per-class notes (markdown + docx) | `class_md/` (Classes 21–42; **no Class 35 gap**, the real Class 35 was added later) |
| Transcripts (Classes 31–42) | `transcripts/` (21–30 transcripts were lost in an earlier reset) |
| Note builder | `build_master_doc.py` |
| Trainer's course SQL | `Snowflake_Notes (7).sql` ⚠️ **contains the trainer's real Snowflake username + password at the top. Sara should remove those lines** (the repo is public). |
| **Sara's dbt project** | repo `saramqureishi/dbt-snowflake-project`, branch `saramqureishi-patch-1` (models are in `models/example/`) |

**Accounts (no passwords stored here):**
- Snowflake trial: account `YVVTNMA-XS79799` (org `YVVTNMA`, region AWS_EU_WEST_2), user `SARAQUREISHI`, role `ACCOUNTADMIN`, `DEV_DB` / `DEV_WAREHOUSE`. Schemas: `DEV_SCHEMA`, `BRONZE`, `SILVER`. **If the trial expires, create a new free trial. Never add billing.** All warehouses are **Gen2** (QAS on by default).
- AWS: account `983367476142`, region `ap-south-1`, bucket `bkt-sara-20261009`, Iceberg external volume `ICEBERG_EXT_VOLUME`, storage integration `AWS_EXT_INTEGRATION`.
- dbt Cloud: connected to the Snowflake trial (target schema `SILVER`) and to GitHub via OAuth.

## 4. Progress log

| Class | Topic | Exam? | Notes | Hands-on |
|---|---|---|---|---|
| 1–20 | Architecture/RBAC, stages, COPY, JSON/Parquet/XML, S3 + storage integration, Snowpipe (SQS), MERGE + Streams (CDC), Tasks (CRON, serverless, DAGs), Airflow (Docker/WSL/Astro) DAG → Snowflake, stored procedures (cursors, exceptions, EXECUTE AS) | ✅ | ✅ (1–21 doc) | ✅ per her notes |
| 21 | UDFs | ✅ | ✅ | ✅ |
| 22 | Exception handling, COPY FORCE/TRUNCATE | ✅ | ✅ | ✅ |
| 23–24 | Hash change detection, SCD Type 2 procedure, ROW_NUMBER dedup | ✅ | ✅ | ✅ |
| 25 | Table types, Time Travel, UNDROP, fail-safe | ✅ | ✅ | ✅ |
| 26 | Transient + external tables | ✅ | ✅ | ✅ |
| 27–28 | Iceberg tables (external volume, DML, Parquet/JSON/Avro files) | ✅ | ✅ | ✅ |
| 29 | Hybrid tables, secure views, dynamic tables | ✅ | ✅ | ✅ |
| 30 | Directory tables, QUALIFY, 3 caches | ✅ | ✅ | ✅ |
| 31 | Caching recap + **24h → 31-day result cache rule** | ✅ | ✅ | skipped (recap) |
| 32 | **QAS, micro-partitions/pruning, clustering keys** | ✅ | ✅ | ✅ |
| 33–41 | **dbt series** (setup, seeds, staging/intermediate/mart, sources/packages, surrogate keys, macros, incremental, tests, snapshots, dbt Core, docs, hooks, ephemeral, vars, tags) | ❌ job skill | ✅ | core dbt project ✅ (see §5) |
| 36 / 38 / 40 | Plain-Snowflake parts: **watermark + MERGE**, **constraint enforcement + validation SQL**, **RESULT_SCAN** | ✅ | ✅ | ✅ done |
| 42 | Back to Snowflake: clustering demo (unfinished), horizontal vs vertical scaling, admin topic list | ✅ | ✅ | multi-cluster warehouse batch **offered, not yet run** |

**Notebook notes (her handwritten notes):** done up to **Class 30**. **Owed: Classes 31–42.** The previous assistant gave her a full list of what to write (exam items in full, dbt as short interview bullets); it's summarised in §6.

## 5. Pending to-do (priority order)

**🟢 Cert (December exam), HIGH priority**
1. **SOS (Search Optimization Service).** The course has promised it since Class 30 and never taught it. The trainer listed it again in Class 42, so it may come next; if not, teach it from Snowflake docs with hands-on. (Enterprise+ feature, serverless credits; good for selective point lookups vs clustering for range scans.)
2. **Iceberg + Dynamic Tables scenario Q&A.** Her flagged **weak spot**, owed for a long time. Plain-English, **scenario-worded** questions, one at a time, honest feedback.
3. **Scenario-style exam drilling.** She sat the exam before and found the questions **confusingly worded**, so practise decoding scenarios, not just definitions.
4. Upcoming course topics: QAS, clustering with/without (real numbers), **resource monitors**, DML vs micro-partitions, horizontal/vertical scaling.
5. Class 42 hands-on (optional): a multi-cluster warehouse (`MIN/MAX_CLUSTER_COUNT`, `SCALING_POLICY` STANDARD vs ECONOMY, `INITIALLY_SUSPENDED=TRUE`, then `USE WAREHOUSE DEV_WAREHOUSE`, then DROP).
6. Write notebook notes 31–42.

**🟡 dbt hands-on (job skill only, NOT exam). She chose to skip these for now**
- Class 35 `dbt_utils` / `generate_surrogate_key` (failed; `packages.yml` was probably in the wrong folder, it must be in the project root, then `dbt deps`).
- Classes 37–38 dbt tests (`not_null`/`unique`/`accepted_values`/`relationships`) + `dbt docs generate`. **Worth doing (~15 min) because her CV mentions dbt tests/docs as a possible add.**
- Class 37 `on_schema_change`; Class 39 snapshots + dbt Core; Classes 40–41 hooks, ephemeral, vars, tags.

## 6. Key facts learned (quick recall)

- **UDF** → SELECT; **procedure** → CALL. Exceptions: STATEMENT_ERROR / EXPRESSION_ERROR / OTHER (OTHER last); SQLCODE/SQLERRM.
- **COPY** remembers loaded files: FORCE=TRUE reloads; TRUNCATE clears load history, DELETE doesn't.
- **SCD2:** hash_key (identity) + hash_data (fingerprint); expire old + insert new; dedup with ROW_NUMBER / QUALIFY.
- **Table types:** permanent (Time Travel up to 90d + 7d fail-safe), transient (≤1d TT, no fail-safe), temporary (session only).
- **Constraints: only NOT NULL is enforced**; PK/UNIQUE/FK are informational (hybrid tables enforce). Validate yourself: dups `GROUP BY … HAVING COUNT(*)>1`; FK orphans `LEFT JOIN parent … WHERE parent.key IS NULL`.
- **Time Travel:** AT/BEFORE (OFFSET / TIMESTAMP / STATEMENT), retention default 1, max 90, UNDROP; fail-safe = Snowflake-only recovery.
- **External table:** data + metadata reads in S3, read-only, needs REFRESH / AUTO_REFRESH. **Iceberg:** data (Parquet) + metadata (JSON/Avro) in S3, full DML, CATALOG + EXTERNAL_VOLUME + BASE_LOCATION.
- **Dynamic table:** TARGET_LAG + WAREHOUSE, automatic incremental refresh. **Secure view** hides its definition.
- **Caches:** result (free, account-wide, survives suspend, **24h, reset on reuse, max 31 days**), local disk (cleared on suspend), metadata (free; COUNT/MIN/MAX). Order: result → local → remote.
- **QAS:** `ENABLE_QUERY_ACCELERATION` + `QUERY_ACCELERATION_MAX_SCALE_FACTOR` (0 = no limit); per-query eligibility (`SYSTEM$ESTIMATE_QUERY_ACCELERATION`); Gen2 on by default. **QAS is NOT vertical scaling**: it offloads eligible scans to serverless compute.
- **Pruning:** min/max per micro-partition; check partitions scanned vs total; **don't wrap the filter column in functions**. **Clustering:** `CLUSTER BY`, `SYSTEM$CLUSTERING_INFORMATION` (overlap/depth), large tables only.
- **Scaling:** vertical = bigger size (complex queries); horizontal = multi-cluster (concurrency, Enterprise+); auto-scale (min<max) vs maximized (min=max); STANDARD (performance) vs ECONOMY (cost).
- **Incremental:** watermark `WHERE ts > MAX(ts) in target` → temp view → MERGE (MATCHED → UPDATE/DELETE, NOT MATCHED → INSERT); dedupe the source first. `LIKE` = structure, CTAS = structure + data, CLONE = zero-copy.
- **RESULT_SCAN(LAST_QUERY_ID())** queries SHOW output (double-quote lowercase columns); 24h.
- **dbt (interview):** medallion bronze/silver/gold; models + `ref()` → lineage/DAG; `source()` + `sources.yml`; `packages.yml` + `dbt deps`; seeds = transient tables; materializations view/table/incremental/ephemeral; `is_incremental()` + `{{ this }}`; tests ↔ constraints (not_null + unique = PK, accepted_values = CHECK, relationships = FK); snapshots = SCD2 (`dbt_valid_to IS NULL` = current; check vs timestamp); `profiles.yml` (in ~/.dbt) vs `dbt_project.yml`; `run`/`seed`/`snapshot`/`test`/`build`.

## 7. Corrections already made (don't repeat these mistakes)

- The words **exam / certification / SnowPro never appear in Classes 33–41**. The trainer's "they may ask you" / "3–4 questions" remarks in the dbt classes are **interview** context, not exam. Notes were corrected.
- He said "three types of incremental" but Class 37 showed only **merge**. Standard dbt-on-Snowflake strategies: merge (default), append, delete+insert (+ newer microbatch). Ask him which three.
- Class 42: the trainer said "QAS is vertical scaling". That's **wrong for the exam** (corrected in the notes).
- Class 32 clustering demo on an 8-partition table showed **no improvement**: clustering only helps big tables.

## 8. Trainer, course and career context

- Trainer **Krishna** (India). The batch is the **7 AM batch**.
- **He offered to call Sara** about cert prep. Sara asked: does the course material map to the exam; how to handle tricky scenario questions; practice tests / study guide for a December exam.
- **Things to get from him:** the **certification-material Drive folder** (promised in Class 42), the **practice questions** he read in Class 31, his **full SQL reference document** (Class 36), to be **added to his WhatsApp events group** (give the +44 number), roughly **how many classes are left** (Class 42: "dbt is done, a few topics pending, one or two sessions"), and whether SOS/QAS/resource monitors will be covered. A draft message for all of this was written.
- **Events:** he attended Snowflake AI-features events (Cortex; the link Sara found was the "Microsoft Copilot Studio + Cortex Agents" quickstart, same topic but not confirmed as the event). He promised an optional Saturday session on it, timing TBA. Sara is in London, so the **London Snowflake User Group** (usergroups.snowflake.com, free evening meetups, some at Snowflake's London office) was recommended for networking.
- **CV:** a final "Modern Data Engineering: Snowflake, dbt, Airflow, Docker & AWS" section was agreed (S3 → Snowpipe ingestion + VARIANT/FLATTEN; dbt medallion project; Airflow + Docker Python DAG; Streams + MERGE + Tasks CDC and SCD2; stored procedures/UDFs; performance features). Rule: **no claims she can't explain, no made-up metrics.** Possible honest adds: dbt tests/docs (after doing them), and a measured warehouse-sizing speed-up (run the same query on XS vs M with the result cache off).

## 9. How to continue (first message for the next session)

1. Read this file, then `class_md/snowflake-class42-notes.md` (latest class).
2. Ask Sara whether she has the **Class 43 link**, or wants to do **SOS / Iceberg + Dynamic Tables Q&A / exam drilling**.
3. Remind her: notebook notes 31–42 are owed, and to get the trainer's certification folder.
