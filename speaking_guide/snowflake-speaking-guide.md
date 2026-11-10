# Snowflake Speaking Guide: Say It Out Loud

**Snowflake — Speaking and Interview Guide**
*Sara — built from your real projects and class notes (Classes 1–47)*

> **How to use this guide.** You do not have a knowledge problem. You have a "saying it out loud" problem, and the only fix is speaking practice. Read a section, then close the page and say it in your own words. Do not memorise the sentences.
>
> **Three rules:**
> - Short answers (20–40 seconds). If you blank, say "Let me think for a second" and breathe.
> - Say what you **did** first. Then say what you **know**.
> - Never invent numbers or claim something you only studied. Section 6 shows you how.
>
> **Contents:** 1 Big picture · 2 Every term in plain English · 3 How the pieces fit · 4 Module by module · 5 Self-quiz (30 questions) · 6 Practice drills and a 7-day plan · 7 Honest framing (built vs studied)
>
> *(Your list jumped from 4 to 8 and 9, so I numbered the sections 1 to 7 in order. Nothing from your list is missing.)*

---

## 1. Big picture

### The problem
Companies have data everywhere: files, apps, spreadsheets, logs. Old databases tie storage and computing power together. When many people run heavy queries, everything slows down, and growing means buying big hardware.

### The idea
**Snowflake keeps the data (storage) separate from the computing power (warehouses).** Data lives once, in the cloud. Any number of independent compute clusters can read it at the same time without getting in each other's way. You pay for compute only while it runs.

### The stack (draw this from memory)
```
        PEOPLE / TOOLS:  analysts, dbt, Airflow, apps
                          |
        +-----------------------------------------+
        |  CLOUD SERVICES (the "brain")           |
        |  login, security, query planning,       |
        |  metadata, caching of results           |
        +-----------------------------------------+
        |  COMPUTE (virtual warehouses)           |
        |  XS, S, M, L ... each runs queries      |
        |  on its own; pause when idle            |
        +-----------------------------------------+
        |  STORAGE                                |
        |  micro-partitions in cloud storage      |
        |  (S3 / Azure / GCS), one copy of data   |
        +-----------------------------------------+
```

### The analogy to reuse in every explanation: the shared library
- **Storage** = the **book stacks**. Books are stored once and are cheap to keep.
- **Warehouses** = **reading rooms you rent by the hour**. A bigger room is faster for heavy work. More rooms means more people reading at once. You stop paying when you leave.
- **Cloud services** = the **librarian and catalogue**. They know where everything is, check who is allowed in, and remember recent answers.

> **Say it:** "Snowflake is like a shared library. The books sit in the stacks once, many reading rooms can use them at the same time, and you only pay for a room while you're using it."

### Your 30-second answer to "What is Snowflake?"
> "Snowflake is a cloud data platform. It keeps storage and compute separate, so many teams can query the same data without slowing each other down, and you pay for compute only while it runs. I've used it to load data from S3, transform it, track changes and keep history."

---

## 2. Every term in plain English

Each term has a definition, an analogy from the library, and a line to say aloud.

### Architecture
**Snowflake**
- **Plain English:** a cloud platform for storing and analysing data, with storage and compute kept separate.
- **Analogy:** the whole shared library.
- **Say it:** "It's a cloud data platform where storage and compute scale independently."

**Virtual warehouse**
- **Plain English:** a cluster of compute that runs your queries. Sizes go XS, S, M, L and so on, and each step up roughly doubles the credits per hour. It can auto-suspend and auto-resume.
- **Analogy:** a reading room you rent. Bigger room, more power, higher rate.
- **Say it:** "A warehouse is the compute that runs queries; I pick the size for the workload and it suspends when idle so I'm not paying."

**Cloud services layer**
- **Plain English:** the always-on layer that handles login, security, metadata, query planning and the result cache.
- **Analogy:** the librarian.
- **Say it:** "It's the brain: authentication, metadata and query optimisation."

**Micro-partition**
- **Plain English:** Snowflake automatically splits table data into small columnar chunks (50–500 MB before compression). They are **immutable**, and each stores min/max values for its columns.
- **Analogy:** a labelled box of pages, with a card on the front saying the lowest and highest value inside.
- **Say it:** "Data is stored in automatic, immutable micro-partitions with metadata that lets Snowflake skip the ones it doesn't need."

**Partition pruning**
- **Plain English:** skipping micro-partitions that cannot contain your answer, using their min/max metadata.
- **Analogy:** reading the labels on the boxes and not opening the ones that can't match.
- **Say it:** "Pruning means scanning fewer partitions, so the query is faster and cheaper."

### Loading
**Stage**
- **Plain English:** a place where files wait to be loaded. Internal stages are inside Snowflake; external stages point to cloud storage like S3.
- **Analogy:** the loading dock.
- **Say it:** "A stage is the landing area for files before they go into tables."

**Storage integration**
- **Plain English:** a secure way for Snowflake to read a private S3 bucket through an IAM role, with no keys in your code.
- **Analogy:** a visitor pass from the building owner, instead of handing out the master key.
- **Say it:** "A storage integration lets Snowflake access private S3 securely without storing credentials."

**COPY INTO**
- **Plain English:** a command that loads files from a stage into a table. It remembers which files it already loaded, so it won't load them twice unless you force it.
- **Analogy:** carrying parcels from the dock to the shelves, once each.
- **Say it:** "COPY INTO is batch loading, and it tracks load history so files aren't duplicated."

**Snowpipe**
- **Plain English:** continuous, serverless loading. When a new file lands in S3, an event notification (via SQS) triggers the pipe, which loads it automatically.
- **Analogy:** a conveyor belt that moves each parcel as it arrives.
- **Say it:** "Snowpipe loads files automatically as they land, without me running anything."

**VARIANT**
- **Plain English:** a column type that holds JSON, Avro, Parquet or XML without a fixed structure. You read inside it with a colon, like `col:name`.
- **Analogy:** a drawer that holds any shape of paper.
- **Say it:** "VARIANT stores semi-structured data, and I query it with path notation."

**FLATTEN**
- **Plain English:** a function that turns an array or nested object into rows.
- **Analogy:** unfolding a folded stack of pages into flat sheets.
- **Say it:** "I use FLATTEN to turn nested JSON arrays into rows I can join and filter."

### Pipelines and history
**Stream**
- **Plain English:** an object that records what changed (inserts, updates, deletes) on a table since you last used it.
- **Analogy:** a "what's new since I last looked" bookmark.
- **Say it:** "A stream captures changes so I only process new data."

**Task**
- **Plain English:** a scheduled or chained SQL job (cron schedule, or run after another task). It can be serverless.
- **Analogy:** an alarm clock that runs a job.
- **Say it:** "A task runs my SQL on a schedule or after another task."

**MERGE**
- **Plain English:** one statement that updates rows that match, inserts rows that don't (and can delete).
- **Analogy:** updating a contact book: fix existing names, add new ones.
- **Say it:** "MERGE does update-or-insert in one statement, which is how I apply changes."

**SCD Type 2**
- **Plain English:** keeping history. When a value changes, you close the old row (end date or a current flag) and insert a new row.
- **Analogy:** crossing out the old address with a date, not erasing it.
- **Say it:** "Type 2 keeps full history: expire the old row, insert the new one."

**UDF vs stored procedure**
- **Plain English:** a UDF returns a value and is used inside a SELECT. A procedure is run with CALL and can run many statements, with logic and error handling.
- **Analogy:** a UDF is a calculator button; a procedure is a recipe with steps.
- **Say it:** "UDFs are for calculations in queries; procedures are for multi-step logic."

### Recovery and storage
**Time Travel**
- **Plain English:** query or restore data as it was in the past. Default retention is 1 day, up to 90 days on higher editions for permanent tables.
- **Analogy:** an undo history.
- **Say it:** "Time Travel lets me query or restore earlier data, within the retention period."

**Fail-safe**
- **Plain English:** a 7-day safety period after Time Travel ends, recoverable **only by Snowflake**. It applies to permanent tables.
- **Analogy:** a vault only the library can open.
- **Say it:** "Fail-safe is Snowflake's last-resort recovery, not something I query."

**Zero-copy clone**
- **Plain English:** an instant copy that shares the same micro-partitions. You pay for extra storage only when either side changes data.
- **Analogy:** two names pointing at the same pages until someone writes on theirs.
- **Say it:** "A clone is instant and free until the data diverges, which is great for testing."

### Performance and cost
**Caches**
- **Plain English:** the result cache (same query, unchanged data, returns the stored answer free), the local disk cache on a warehouse, and metadata answers like COUNT.
- **Analogy:** reusing yesterday's answer sheet if the question and books haven't changed.
- **Say it:** "Repeated queries can come straight from the result cache, which costs nothing."

**Clustering key**
- **Plain English:** tells Snowflake to keep similar values together, mainly to help **range** filters on **very large** tables.
- **Analogy:** sorting the boxes by date.
- **Say it:** "A clustering key improves pruning for range filters on big tables."

**Search Optimization Service (SOS)**
- **Plain English:** an extra search structure that speeds up selective **lookups** (equality, and some substring/VARIANT searches) on large tables. It costs storage and background credits.
- **Analogy:** an index of "find this exact name".
- **Say it:** "SOS is for point lookups; clustering is for ranges."

**Query Acceleration Service (QAS)**
- **Plain English:** offloads parts of big eligible scans to extra serverless compute. It is **not** the same as making the warehouse bigger.
- **Analogy:** borrowing extra helpers for one heavy lift.
- **Say it:** "QAS gives a per-query boost without resizing the warehouse."

**Multi-cluster warehouse**
- **Plain English:** a warehouse that adds more clusters when many queries queue (horizontal scaling, Enterprise edition or higher).
- **Analogy:** opening more reading rooms when the queue is long.
- **Say it:** "Bigger size is for complex queries; more clusters is for many users at once."

**Resource monitor**
- **Plain English:** a credit budget with actions at percentages: notify, suspend, or suspend immediately. It can apply to one warehouse or the whole account.
- **Analogy:** a spending limit alert on a card.
- **Say it:** "A resource monitor stops runaway cost by alerting or suspending at a credit threshold."

### Sharing and modern tables
**Share**
- **Plain English:** read-only, no-copy access to your data for another account. The consumer queries your live data. For people without Snowflake, you create a **reader account**.
- **Analogy:** lending a window to read the books, not a photocopy.
- **Say it:** "Sharing gives another account live, read-only access with no data copied."

**Dynamic table**
- **Plain English:** a table defined by a query that Snowflake keeps refreshed within a target lag.
- **Analogy:** a report that updates itself.
- **Say it:** "I declare the query and the lag, and Snowflake maintains the table."

**Iceberg table**
- **Plain English:** a table stored in an open format in **your own** cloud storage (through an external volume), so other engines can read it too.
- **Analogy:** books on your own shelves, labelled in a universal catalogue other libraries can read.
- **Say it:** "Iceberg tables use an open format so multiple engines can share the same data."

### Tools around Snowflake
**dbt**
- **Plain English:** a tool that turns SQL select statements into tables and views, with dependencies tracked by `ref()`. It also runs tests and builds docs.
- **Analogy:** a recipe book that turns raw ingredients into finished dishes, in the right order.
- **Say it:** "dbt manages my transformations as versioned SQL models with lineage."

**Airflow and DAG**
- **Plain English:** a scheduler. A DAG is a set of tasks with dependencies (run A, then B, then C).
- **Analogy:** a manager who says what runs when.
- **Say it:** "Airflow orchestrates the steps; each step can trigger work in Snowflake."

**Medallion architecture**
- **Plain English:** layers of data quality: bronze (raw), silver (cleaned), gold (business-ready).
- **Analogy:** rough ingredients, prepared ingredients, finished dish.
- **Say it:** "I land raw data in bronze, clean it in silver, and shape it for reporting in gold."

---

## 3. How the pieces fit: the step story of how data becomes an answer

Tell this as a story, in order. This is the one to practise drawing on paper.

1. **A file lands in S3.** For example, a JSON or CSV file from an application.
2. **Snowflake is allowed in.** A storage integration lets it read the private bucket, and an external stage points to the folder.
3. **The file is loaded.** Snowpipe notices the new file (an S3 event goes through SQS) and loads it into a raw table, often as VARIANT. This is the bronze layer.
4. **The shape is fixed.** FLATTEN and VARIANT paths turn nested JSON into proper rows and columns.
5. **Changes are detected.** A stream on the raw table shows only the new or changed rows.
6. **Changes are applied.** A task runs a MERGE into a cleaner table (silver). If history matters, a Type 2 pattern expires old rows and inserts new ones.
7. **Business models are built.** dbt models turn silver into gold tables that analysts use, in the right order thanks to `ref()`.
8. **The schedule is managed.** Airflow (or tasks) triggers each step and handles dependencies.
9. **People query it.** Their queries run on a warehouse. Pruning, caches and clustering/SOS make them faster. A resource monitor protects the budget.
10. **Other teams get the data.** A share gives another account read-only access, with no copy.

> **Which steps you built yourself:** steps 1 to 6 (S3, Snowpipe, VARIANT/FLATTEN, streams, MERGE, tasks, SCD2), a dbt project (7), and an Airflow DAG (8). Steps 9 and 10 you tried in labs. Section 7 tells you exactly how to word that.

---

## 4. Module by module

Each module has: what you did, why it matters, a paragraph to say, and likely follow-up questions with answer hints. Edit the "say it" paragraphs until they sound like you.

### Module 1: Loading from S3 (storage integration, stages, COPY, Snowpipe)
- **What you did:** connected Snowflake to an S3 bucket with a storage integration, created stages, loaded with COPY, then automated it with Snowpipe.
- **Why:** files arrive all day. Manual loading is slow and error-prone.
- **Say it like this:** "I connected Snowflake to a private S3 bucket using a storage integration, so no keys sit in code. I created an external stage over the folder and first loaded with COPY INTO. Then I automated it with Snowpipe, so each new file loads as it lands."
- **Likely follow-ups:**
  - *Why a storage integration?* Secure access via an IAM role; no stored keys.
  - *COPY vs Snowpipe?* COPY is batch and run by you on a warehouse; Snowpipe is continuous, event-triggered and serverless.
  - *What if a file loads twice?* COPY remembers loaded files; `FORCE = TRUE` reloads on purpose.
  - *How does Snowpipe know about new files?* An S3 event notification goes through SQS to the pipe.

### Module 2: Semi-structured data (VARIANT, FLATTEN)
- **What you did:** loaded JSON (and looked at Parquet and XML), stored it in VARIANT and flattened arrays into rows.
- **Why:** real data is often nested and its shape changes.
- **Say it like this:** "I loaded JSON into a VARIANT column so I didn't need a fixed schema up front. Then I used path notation to read fields and FLATTEN to turn arrays into rows I could join."
- **Likely follow-ups:**
  - *How do you read a field?* `col:key`, and cast it, for example `::STRING`.
  - *What does FLATTEN return?* One row per array element.
  - *Why not a normal table?* A fixed schema breaks when the source changes.

### Module 3: Change capture (Streams, MERGE, Tasks)
- **What you did:** put a stream on a table, used MERGE to apply changes, and scheduled it with tasks (cron, and chains of tasks).
- **Why:** processing only what changed is cheaper and faster than reloading everything.
- **Say it like this:** "I put a stream on the raw table so I could see only new and changed rows. A task ran on a schedule and used MERGE to update matching rows and insert new ones. I deduplicated the source first so MERGE didn't hit duplicates."
- **Likely follow-ups:**
  - *What does a stream hold?* Changed rows plus metadata columns saying what the change was.
  - *When does a stream empty?* When its data is consumed by a DML statement in a transaction.
  - *What can a task do?* Run on a schedule or after another task; can be serverless.
  - *What if the source has duplicates?* MERGE can fail or behave unpredictably, so deduplicate first (for example `ROW_NUMBER` or `QUALIFY`).

### Module 4: SCD Type 2, stored procedures and UDFs
- **What you did:** built a Type 2 pattern with a hash to detect change, expired the old row and inserted the new one. Wrote procedures with error handling, and UDFs.
- **Why:** reports often need history, such as "what was this customer's address in March?"
- **Say it like this:** "To keep history I used a Type 2 pattern. I hashed the business columns to detect a change, closed the old row and inserted a new current row. I wrapped the logic in a stored procedure with exception handling, and used UDFs for small reusable calculations."
- **Likely follow-ups:**
  - *Type 1 vs Type 2?* Type 1 overwrites; Type 2 keeps history.
  - *Why a hash?* One comparison tells you if any tracked column changed.
  - *UDF vs procedure?* A UDF returns a value inside a SELECT; a procedure is called and can run multiple statements.
  - *How do you handle errors?* Exception blocks, and the SQLCODE/SQLERRM values.

### Module 5: dbt
- **What you did:** set up a dbt project against Snowflake, with seeds, staging, intermediate and mart models, sources and macros. (Check Section 7 for what you have and haven't run.)
- **Why:** SQL transformations become versioned, ordered and reusable.
- **Say it like this:** "I built a dbt project with a bronze-silver-gold structure. Models reference each other with `ref()`, so dbt knows the build order and shows lineage. Sources are declared in a YAML file so database and schema names aren't hard-coded."
- **Likely follow-ups:**
  - *What does `ref()` do?* Links models and builds the dependency graph.
  - *What are the materializations?* View, table, incremental, ephemeral.
  - *How does incremental work?* `is_incremental()` plus `{{ this }}` filter to new rows; the default strategy on Snowflake is merge.
  - *What are dbt tests?* not_null, unique, accepted_values, relationships. **Be honest if you haven't run them yet.**

### Module 6: Airflow and Docker
- **What you did:** ran Airflow in Docker, wrote a Python DAG, and used it to run work against Snowflake.
- **Why:** pipelines need scheduling, ordering and retries.
- **Say it like this:** "I ran Airflow in Docker and wrote a Python DAG that triggers the Snowflake step on a schedule. The DAG defines the order and dependencies of the tasks."
- **Likely follow-ups:**
  - *What is a DAG?* A directed graph of tasks with no loops.
  - *Why Airflow if Snowflake has tasks?* Airflow can orchestrate across many systems, not only Snowflake.
  - *Why Docker?* A repeatable local environment.

### Module 7: Recovery and table features (Time Travel, clone, UNDROP, table types)
- **What you did:** used Time Travel, UNDROP, zero-copy cloning, and compared permanent, transient and temporary tables.
- **Why:** mistakes happen and testing needs safe copies.
- **Say it like this:** "If someone drops a table, UNDROP brings it back while Time Travel retention remains. I can query an earlier state with AT or BEFORE. For testing, a zero-copy clone gives me a full copy instantly, and I only pay for storage when the data diverges."
- **Likely follow-ups:**
  - *Retention?* Default 1 day; up to 90 on higher editions for permanent tables.
  - *Fail-safe?* 7 days after Time Travel, Snowflake support only.
  - *Do transient tables have fail-safe?* No.
  - *Does a clone copy data?* No; it shares micro-partitions until changes happen.

### Module 8: Performance and cost
- **What you did:** looked at the three caches, micro-partitions and pruning, clustering keys, SOS, QAS, scaling, and a resource monitor in a trial account.
- **Why:** fast queries and controlled spend.
- **Say it like this:** "For speed I check partitions scanned versus total. Clustering helps range filters on very large tables, SOS helps point lookups. For cost, I size warehouses to the workload, auto-suspend them, and a resource monitor can alert or suspend at a credit limit. In my labs the tables were small, so I didn't see a speed-up, but I verified the syntax and the cost behaviour."
- **Likely follow-ups:**
  - *Vertical vs horizontal scaling?* Bigger warehouse for heavy queries; more clusters for concurrency.
  - *Clustering vs SOS?* Range vs equality lookups.
  - *Is QAS the same as scaling up?* No; it offloads eligible work to serverless compute.
  - *How would you find an expensive query?* Query history, sorted by time or bytes scanned.

### Module 9: Sharing, Iceberg, dynamic and hybrid tables
- **What you did:** created a share and granted objects to it, worked with Iceberg tables on S3, and tried dynamic and hybrid tables.
- **Why:** collaboration without copying data, and open formats.
- **Say it like this:** "I created a share and granted a database, schema and table to it, which gives another account read-only access without copying data. For open formats I created Iceberg tables with an external volume on S3, so other engines can read the same data."
- **Likely follow-ups:**
  - *Can a consumer change shared data?* No; it is read-only.
  - *Non-Snowflake consumers?* A reader account the provider creates and pays for.
  - *Iceberg vs external table?* Iceberg supports full DML from Snowflake and uses an open metadata format; an external table is read-only.
  - *Hybrid table?* Built for transactional workloads; the primary key is required and enforced.

---

## 5. Self-quiz: 30 questions with short answers

Cover the answers, say each one aloud, then check.

1. **What is Snowflake?** A cloud data platform with storage and compute separated.
2. **Name the three layers.** Storage, compute (virtual warehouses), cloud services.
3. **Why separate storage and compute?** Scale each independently; many warehouses read the same data without contention; pay for compute only when it runs.
4. **What is a micro-partition?** An automatic, immutable, columnar chunk (50–500 MB before compression) with min/max metadata.
5. **What is pruning?** Skipping partitions that cannot match, using that metadata.
6. **Internal vs external stage?** Internal is inside Snowflake; external points to cloud storage like S3.
7. **Why use a storage integration?** Secure access to a private bucket without storing keys.
8. **COPY vs Snowpipe?** COPY is batch, run by you; Snowpipe is continuous, event-triggered and serverless.
9. **What is VARIANT?** A column type for semi-structured data such as JSON.
10. **What does FLATTEN do?** Turns arrays or nested objects into rows.
11. **What is a stream?** An object that tracks changes on a table since it was last consumed.
12. **What is a task?** A scheduled or chained SQL job, optionally serverless.
13. **What does MERGE do?** Updates matching rows, inserts new ones, optionally deletes, in one statement.
14. **What is SCD Type 2?** Keeping history by expiring the old row and inserting a new one.
15. **UDF vs stored procedure?** UDF returns a value in a SELECT; a procedure is CALLed and runs multiple steps.
16. **What is Time Travel?** Querying or restoring earlier data; default 1 day, up to 90 on higher editions, permanent tables.
17. **What is Fail-safe?** 7 days after Time Travel; recoverable only by Snowflake; permanent tables.
18. **Which table types lack Fail-safe?** Transient and temporary.
19. **What is a zero-copy clone?** An instant copy sharing micro-partitions; storage cost only when data changes.
20. **Which constraint is enforced on a normal table?** NOT NULL only. Primary key, unique and foreign key are informational (hybrid tables enforce them).
21. **What is the result cache?** Returns a stored result for an identical query on unchanged data, free; lasts 24 hours, renewed on reuse up to 31 days.
22. **Vertical vs horizontal scaling?** Bigger warehouse vs more clusters (multi-cluster, Enterprise or higher).
23. **What is QAS?** Offloads parts of eligible large scans to serverless compute; not the same as resizing.
24. **Clustering key vs SOS?** Clustering for range filters; SOS for equality lookups. Both need large tables.
25. **What does SOS cost?** Extra storage plus background (serverless) credits.
26. **What is a resource monitor?** A credit budget with notify, suspend and suspend-immediate actions; account or warehouse level.
27. **What is a share, and how do non-Snowflake users read it?** Read-only, no-copy access for another account; non-Snowflake users get a provider-created reader account.
28. **What is a dynamic table?** A table defined by a query that Snowflake refreshes within a target lag.
29. **What does `ref()` do in dbt, and what is the default incremental strategy on Snowflake?** `ref()` links models and builds the order; the default incremental strategy is merge.
30. **What is an Airflow DAG?** A set of tasks with dependencies and no loops, run in order by a scheduler.

---

## 6. Practice drills and a 7-day plan

Aim for **15 to 20 minutes a day**. Say everything out loud, standing or walking if you can.

### Seven drills
1. **One-breath pitch.** Say the 30-second "What is Snowflake?" answer. Record it on your phone. Listen once. Do it again, smoother.
2. **The friend test.** Explain Snowflake to a non-technical friend (or the wall) using only the library analogy. No jargon.
3. **Draw and narrate.** On blank paper, draw the 10-step story from Section 3 from memory, and talk through it as you draw.
4. **The "why" ladder.** Say a short answer, then ask yourself "why?" three times and answer each. Example: Snowpipe → why serverless → why event-triggered.
5. **The "I don't know" drill.** Practise honest lines until they feel normal:
   - "I haven't used that yet, but I understand it works like this..."
   - "I've only seen that in a lab, not in production."
   - "I'd need to check the documentation for the exact syntax."
6. **Built vs studied.** Pick three topics and describe each with the correct verb (Section 7): built, tried, or studied.
7. **Mock interview.** Ten questions, one at a time, with me. I give honest feedback after each answer.

### Seven-day plan
| Day | Do this | Time |
|---|---|---|
| 1 | Read Section 1. Drill 1 (pitch) and Drill 2 (friend test). | 15 min |
| 2 | Section 2, terms from Snowflake to Snowpipe, said aloud. | 20 min |
| 3 | Section 2, the rest of the terms. Quiz questions 1–15. | 20 min |
| 4 | Section 3. Drill 3 (draw and narrate). | 20 min |
| 5 | Modules 1–5: read each "say it like this", then say it your way. Drill 4. | 20 min |
| 6 | Modules 6–9, Section 7. Drills 5 and 6. | 20 min |
| 7 | Quiz questions 16–30, then Drill 7, the mock interview with me. | 25 min |

If you miss a day, do not restart. Pick up from the next day.

---

## 7. Honest framing: what you built vs what you only studied

Interviewers can tell the difference, and being clear about it makes you more credible, not less. Use the right verb.

| Verb | Meaning | Use it for |
|---|---|---|
| **"I built / I implemented"** | You did it end to end yourself | The topics in the first table |
| **"I tried it in a lab"** | You ran it on a trial account, maybe on small data | The second table |
| **"I understand how it works"** | You studied it but haven't run it | The third table |

### Check this table, and change anything that isn't true for you
**I built (green)**
- S3 to Snowflake loading with a storage integration, stages and COPY
- Snowpipe auto-loading
- JSON in VARIANT, with FLATTEN
- Streams, MERGE and Tasks for change capture
- SCD Type 2 with a stored procedure
- Stored procedures with exception handling, and UDFs
- An Airflow DAG running in Docker against Snowflake
- A dbt project (seeds, staging, intermediate, marts, sources, macros)
- Time Travel, UNDROP, zero-copy clones, table types
- Iceberg tables with an external volume on S3

**I tried it in a lab (yellow)**
- Resource monitor (created, attached, altered and removed)
- Data sharing, provider side only (share, grants, read-only proof)
- Clustering key and SOS (syntax and cost verified; no visible speed-up because the table was too small)
- Query Acceleration Service settings
- Hybrid tables and dynamic tables (as covered in class)

**I understand how it works, but haven't run it (red)**
- Reader accounts and the consumer side of sharing (needs a second account)
- Cortex AI functions, Cortex Search and Cortex Analyst (functions are blocked on trial accounts)
- dbt tests, docs, snapshots, hooks, and packages such as `dbt_utils` (not run yet; the packages attempt failed)
- Snowpark, Snowflake ML, Notebooks and Streamlit (not taught in the course)
- Multi-cluster warehouses (not run yet)

> **Edit this.** It is built from your handover record. If something is in the wrong column, move it. As you do more labs, move items from red to yellow to green.

### Phrases that stay honest
- "I built a pipeline that..." (only for the green list)
- "In a trial account I tested..." (yellow)
- "I've studied that and I understand the idea, but I haven't run it yet." (red)
- "On small lab data I didn't see a speed-up, but I checked the syntax and cost behaviour."

### Rules for your CV and interviews
- **No invented numbers.** Say "I verified it works" instead of "improved performance by 40%".
- **No claims you can't explain** with a follow-up question. If you can't answer "why?" twice, say "I've seen it, but I'm still learning it."
- **A measured result is fine.** If you run the same query on a small and a medium warehouse with the result cache off, you can honestly report what you measured.

---

*End of guide. Next step: do Day 1 today, then come back and I'll run Drill 7, the mock interview, whenever you're ready. We can also start sooner with a few questions.*
