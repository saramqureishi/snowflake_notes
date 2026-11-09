# Class 45 — Micro-Partitions, Partition Pruning, Clustering Keys & DML on Immutable Partitions

**Snowflake — Class 45 Notes**
*Sara — SnowPro Core preparation*

> ⭐⭐ **Exam-relevant class.** This is the performance block promised since Class 42: micro-partitions, partition pruning, clustering keys and what INSERT/UPDATE/DELETE do to micro-partitions. All of it is SnowPro Core material. The clustering demo was again **inconclusive on his small table**, but the concepts are what the exam tests.
>
> **Honest labelling:**
> - **§1** (synthetic data, PII/PHI) is a short context piece. Useful vocabulary, light exam value.
> - **§2–§7** are the exam content.
> - **SOS (Search Optimization Service) was NOT taught.** He said "tomorrow" again. It is the next class, per him.
> - The first ~8 minutes of the recording are setup and the transcript is very quiet there. Nothing was lost.
>
> **Things he said that matter to you (flagged as you asked):**
> - 🗓️ **Stored procedures and functions** (a topic you already did in Classes 14–21): a student asked about them. He said he'll finish the performance topics first, and that **procedures and functions together "will take a complete week."** So a long block is coming later. Ask him whether it is new material or a repeat of what you've done.
> - 💼 A student said he was asked about **"SOFT CA"** (garbled, can't tell what this was) in an interview about **building a single dbt model**, and the command differed from what was taught. Could be `dbt run --select <model>`, but I can't confirm from the audio.
> - 🔁 The same student asked Krishna to update **"profiles"** and re-ping him. Unclear whether this means resumes or dbt `profiles.yml`; the audio is ambiguous.
> - 📺 He mentioned an **event "yesterday"** and said he'd complete something about it. No detail given.
> - ⚠️ **Two statements to treat carefully for the exam** (see §6 and §8): the "index" analogy for clustering, and his "query pruning vs partition pruning" distinction.

---

## 1. Synthetic data and sensitive information (context, light)

- **Synthetic data** = fake data generated to look real. You use it when real data is sensitive, e.g. in healthcare or finance.
- **PII** (personal information, e.g. a US SSN or an Indian Aadhaar number) and **PHI** (protected health information, e.g. a patient's insurance and diagnosis) must not be disclosed.
- He generated about **20 million rows** with Snowflake's data-generation functions:
  - `TABLE(GENERATOR(ROWCOUNT => n))` produces n rows.
  - `UNIFORM(min, max, RANDOM())` gives random values in a range.
  - `SEQ8()` gives a sequence of numbers.
- Use these to build big test tables for any performance experiment, as he did.

## 2. Micro-partitions ⭐⭐

- Snowflake **automatically** splits table data into **micro-partitions** as you load it. You never create or manage them.
- Size: he said **50 MB to 500 MB** each, quoting the documentation. (Confirmed in Snowflake's docs on 9 Nov: **50–500 MB of uncompressed data**; the stored size is smaller because data is compressed. Some third-party guides say "compressed", which does not match the docs.)
- His demo: 20 million rows needed only **8 partitions**. Check it in **Query Profile → partitions total**.
- ⭐ Each micro-partition stores **metadata** about its columns (min/max values per column and similar). This metadata is what pruning uses (see §3).
- Micro-partitions are **columnar** and **immutable** (see §5).

## 3. Partition pruning ⭐⭐

- **Partition pruning** = skipping the micro-partitions that cannot contain your data, using each partition's min/max metadata.
- Why it matters: the query is **faster** and uses **less compute** (lower cost).
- How to check: run the query, open the **Query Profile** and compare **partitions scanned** with **partitions total**. Scanned much lower than total means pruning worked.
- His first test: `WHERE emp_id = <one value>` on 20M rows still scanned **all 8 of 8** partitions, because the values were spread across every partition so none could be skipped.
- A date-range filter also scanned all partitions. A **narrow** range (one month, ~23,000 rows) **still** scanned all of them, so the data was spread everywhere.
- ⭐ **Lesson:** pruning only works if rows with similar values sit **together** in the same partitions. Clustering is how you arrange that.

## 4. Clustering keys ⭐⭐

A **clustering key** tells Snowflake to organise the table's rows so similar values for the chosen column(s) are stored in the same micro-partitions. That improves pruning.

```sql
-- is the table clustered? (before clustering it reports "not clustered")
SELECT SYSTEM$CLUSTERING_INFORMATION('emp');

-- add a clustering key to an existing table
ALTER TABLE emp CLUSTER BY (hire_date);

-- two columns, as in his second demo
ALTER TABLE emp CLUSTER BY (hire_date, job);

-- remove it
ALTER TABLE emp DROP CLUSTERING KEY;
```

- After changing the key, the table is **re-organised in the background**. He had to **wait a couple of minutes** for the metadata to refresh before the numbers changed. (This background work is **automatic clustering**, which **uses credits**; recall Class 32.)
- He suspended the warehouse before re-running (`ALTER WAREHOUSE ... SUSPEND`). The transcript does not give his reason; clearing the **local disk cache** is my inference. ⭐

### How to choose a clustering key ⭐ (his answer to a student's question)

- Use columns that appear in your **`WHERE` filters, range filters and join/sort conditions**. Date columns are the most common choice.
- **Avoid very high cardinality columns** (almost every value unique, e.g. an employee ID).
- **Cardinality** = number of **distinct** values. `SELECT COUNT(DISTINCT col)`. His data: one column had **41** distinct values out of 20M (low); another had ~20M (high).
- Cardinality should be **moderate**: enough distinct values to prune, not so many that every value is unique.
- ⭐ **Table size matters**: clustering is recommended for **very large tables**, with a large number of micro-partitions, typically **multi-terabyte**. That is why his small demo tables showed little benefit.

### Trick for dates ⭐ (the one demo that worked)

A raw timestamp or full date can be **too high cardinality**. He clustered on an **expression** that reduces it, here `DATE_TRUNC` to month:

```sql
ALTER TABLE emp CLUSTER BY (DATE_TRUNC('MONTH', hire_date));
```
- Result (as he said it): the query scanned **2 of 16** partitions instead of all of them. **Caveat (9 Nov):** the audio around [54:25–58:28] is garbled ("trunk … date"). The **month-level `DATE_TRUNC`** expression is my reading; he may have used a different truncation. Your own lab used a 20M-row table with only **4 partitions**, so you could not reproduce this.
- **Related gotcha from Class 42:** do not wrap the *filter* column in a function in the `WHERE`. That is separate from clustering on an expression, which is allowed.

## 5. What INSERT / UPDATE / DELETE do to micro-partitions ⭐⭐ (he said this is very important)

**Micro-partitions are immutable.** Snowflake never edits one in place.

| Operation | What happens |
|---|---|
| **INSERT** | Creates **new** micro-partitions |
| **UPDATE** | Does **not** modify existing partitions. It writes **new** partitions containing the changed rows; the old ones stay |
| **DELETE** | Old partitions are left alone. Snowflake writes **new** partitions with the **remaining** data |
| **DELETE all rows** | Per his explanation, the partitions are untouched and no new ones are created (Snowflake's docs also say deleting all rows is a metadata-only operation) |
| **DROP TABLE** | Different: recoverable with `UNDROP` if Time Travel is on |

- His UPDATE example: 20 partitions, 5 hold "engineer" rows. Changing them to "snowflake developer" makes **5 new partitions**; the 5 old ones remain.
- ⭐ **Why this matters (exam link):** the retained old partitions are what make **Time Travel, UNDROP and zero-copy cloning** possible. If you change data by mistake, Snowflake still has the earlier version.
- ⭐ **Without Time Travel retention**, you cannot restore the old data. (Recall Class 44: `DATA_RETENTION_TIME_IN_DAYS = 0` means no recovery.)
- Old partitions that Time Travel no longer needs go into **fail-safe** and then are purged (Class 25).
- In the demo the partition count went from 32 to 64 to 110 as the data was loaded and then updated. That is the new-partition behaviour in action.
- He separated this from caching: re-running the same `SELECT` is served from the **result cache**, which is unrelated to partitions.

## 6. The index analogy (understand it, but don't write it in the exam)

- He compared a clustering key to the **index page of a 500-page book**. If you know the topic you jump to the page; otherwise you scan every page.
- Table = book, micro-partitions = pages, clustering key = index.
- ⚠️ **Careful:** useful as a mental picture, but **Snowflake has no traditional indexes**. A clustering key is not an index; it is a co-location of similar rows that improves pruning.

## 7. Search Optimization Service (preview only)

- He mentioned it as the "one more thing" and said SOS will be covered **tomorrow**.
- Related student question: "is partition pruning the same as query pruning?" He deferred it until SOS.

## 8. His "query pruning vs partition pruning" explanation ⚠️

- His answer: *partition pruning* avoids scanning unnecessary **partitions**; *query pruning* avoids scanning unnecessary **queries**, and he'll explain with SOS.
- ⚠️ **"Query pruning" is not a standard Snowflake exam term** that I can verify, and "avoiding queries" is not how pruning works. Treat "pruning" as meaning **skipping micro-partitions**. Hold this until he explains it tomorrow, then compare with the Snowflake docs.

## 9. Previewed for NEXT class

- ⭐ **Search Optimization Service (SOS).** Then QAS.
- Procedures and functions (about a week), later.

## 10. Cheat-sheet / quick recall

- **Micro-partitions:** automatic, columnar, immutable, ~50–500 MB (uncompressed); each holds min/max metadata. ⭐⭐
- **Partition pruning:** skip partitions using metadata. Check **partitions scanned vs total** in Query Profile. ⭐⭐
- **Clustering key:** `ALTER TABLE t CLUSTER BY (col)`; check with `SYSTEM$CLUSTERING_INFORMATION`; remove with `DROP CLUSTERING KEY`. Re-clustering runs in the background and **uses credits**. ⭐
- **Pick columns:** used in `WHERE`/range/join; **not** very high cardinality; table must be **very large (TB-scale)**. ⭐
- **Date trick:** `CLUSTER BY (DATE_TRUNC('MONTH', date_col))` reduced cardinality and gave **2 of 16** partitions. ⭐
- **DML on immutable partitions:** INSERT → new; UPDATE → new partitions, old kept; DELETE → remaining data written as new, old kept. ⭐⭐
- **Old partitions enable** Time Travel, UNDROP, cloning. Retention 0 means no restore. ⭐
- **Benchmarking tip (my inference, not stated by him):** suspend the warehouse to clear the local cache before re-running; the result cache can be switched off with `ALTER SESSION SET USE_CACHED_RESULT = FALSE`.
- **Cardinality** = distinct values (`COUNT(DISTINCT)`).
- ⚠️ Snowflake has **no indexes**; "query pruning" is not a term to rely on.
- **Lab (9 Nov):** 20M generated rows = only **4 micro-partitions** (126 MB), so no pruning was possible. `EXPLAIN USING TEXT` shows `partitionsTotal` and `partitionsAssigned`. `SYSTEM$CLUSTERING_INFORMATION` showed `average_depth` 4.0 (unclustered) when checked straight after adding the key.
- 🔜 Next: **SOS**.

*End of Class 45 notes. A concepts-heavy performance class: micro-partitions, partition pruning, clustering keys and how to choose them, the DATE_TRUNC clustering trick, and the immutability rule that explains how INSERT/UPDATE/DELETE affect storage and make Time Travel possible. SOS was pushed to the next session.*
