# Class 30 — Directory Tables, QUALIFY & Caching
## Snowflake — Class 30 Notes
### Directory Tables · QUALIFY · Caching (3 types) + micro-partitions/pruning intro
Class length: ~68 min. Honest labeling: This class covers four things: (1) a quick look at dynamic table lineage, (2) Directory tables (querying files on a stage), (3) the `QUALIFY` clause (a cleaner way to do the ROW_NUMBER dedup from Class 24), and the main topic — (4) Caching in Snowflake (the three cache types + how a query decides where to read from). It ends introducing micro-partitions, pruning, percentage-scanned-from-cache, and previews QAS, SOS, clustering keys for the next class. Cross-referenced with the trainer's SQL notes (the Class-30 section: caches, QAS, SOS, clustering, pruning, QUALIFY, query acceleration).
### 1. Dynamic Table Lineage (quick)
- In Snowsight, a dynamic table shows a Refresh History and a Graph/Lineage view.
- Lineage = a visual map of which base tables the dynamic table is built from (e.g. customer + nation). It shows exactly which tables feed the refresh.
- The TARGET_LAG (e.g. 2 min) is shown as the refresh schedule.
### 2. Directory Tables ⭐
A directory table lets you query the list of files on a stage using SQL (instead of just LIST @stage).
- Enabled with `DIRECTORY = (ENABLE = TRUE)` when creating the stage.
- Check: SHOW STAGES → the `directory_enabled` column (Y/N).
- Query the files:
SELECT * FROM DIRECTORY(@stage_name);
- If the stage was created without directory enabled, you get: *"a directory is not enabled for this stage."* Fix it:
ALTER STAGE csv_stage SET DIRECTORY = (ENABLE = TRUE);
What columns you get: file name/relative_path, size, last_modified, file_url, etc. You can click the file_url to download the file.
Why it's useful — you can run SQL on the file list:
-- files placed in the last 1 hour
SELECT * FROM DIRECTORY(@csv_stage)
WHERE last_modified >= DATEADD('hour', -1, CURRENT_TIMESTAMP());

-- total size of all files received (audit)
SELECT SUM(size) FROM DIRECTORY(@csv_stage);
🧠 Directory table = a queryable catalog of the files on a stage. Instead of LIST @stage (which just dumps everything), you can filter by date, sum sizes, audit "how many files did we receive today and how big." Great for monitoring ingestion. Works on internal and external stages.
### 3. The `QUALIFY` clause ⭐⭐ (cleaner dedup)
In Class 24 you de-duplicated with ROW_NUMBER() inside a subquery, then filtered WHERE rn = 1. `QUALIFY` does the same thing in one step — it's Snowflake's way of filtering on a window function without the subquery.
Old way (subquery):
SELECT * FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY hashkey_pk
             ORDER BY etl_source_load_date DESC) AS rn
    FROM temp_emp_data_raw
) WHERE rn = 1;
New way (`QUALIFY`):
SELECT *
FROM temp_emp_data_raw
WHERE emp_id IS NOT NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY hashkey_pk
        ORDER BY etl_source_load_date DESC) = 1;
- QUALIFY filters on the result of a window function (ROW_NUMBER, RANK, etc.), the same way WHERE filters rows and HAVING filters groups.
- Both queries return the same de-duplicated 10 rows — QUALIFY is just cleaner (no wrapping subquery).
🧠 `QUALIFY` = `WHERE` but for window functions. WHERE → filters rows; HAVING → filters groups (after GROUP BY); `QUALIFY` → filters on window functions (after they're computed). Snowflake-specific. Classic use: QUALIFY ROW_NUMBER() OVER(...) = 1 for dedup.
### 4. Caching ⭐⭐⭐ (the big topic)
Cache = temporary storage of results/data so repeat work is fast. Snowflake has THREE caches:

#### How a query decides where to read (the order of preference) ⭐⭐
When you run a query, Snowflake checks in this order:
1. Result Cache first — "has this exact query been run before and the result is still cached?" If yes → return instantly (no warehouse needed, ~sub-second).
1. Local/Warehouse Cache next — if not in result cache, does the warehouse already have the needed micro-partitions in its local disk? Partial reads possible.
1. Remote Disk (actual storage) last — if neither cache has it, read from the real storage (slowest).
#### Demonstrated live
- First run of a big query: 2 min 42 sec (cold — read from remote disk).
- Second run (unchanged): under 1 second — came from the Result Cache.
- How to prove it was the result cache: open the query profile → you'll see "Query Result Reuse". That means it reused a cached result (didn't run again).
#### Result Cache details ⭐
- Reused only if the query is identical and the underlying data hasn't changed.
- Disable it to test: ALTER SESSION SET USE_CACHED_RESULT = FALSE; (re-enable with TRUE; default is TRUE).
- With result cache disabled, the same query runs slow again (goes to warehouse/remote).
#### Local Disk / Warehouse Cache details ⭐
- Stores the micro-partition data the warehouse read (not the final result — the raw data chunks).
- Tied to the warehouse — if you SUSPEND the warehouse, this cache is cleared/lost. (Demonstrated: suspend → next run cold again.)
- AUTO_SUSPEND controls when a warehouse suspends after being idle (default 10 minutes; set e.g. ALTER WAREHOUSE dev_wh SET AUTO_SUSPEND = 120; for 2 min). When it suspends, the local cache goes away.
- In the query profile, "Percentage scanned from cache" shows how much came from local cache:
- 0% = read entirely from remote disk (cold).
- >0% (e.g. 10%) = that portion came from the warehouse's local cache (warm).
🧠 The three-cache mental model:
- Result cache = "the exact answer I gave you before" (fastest, global, survives warehouse suspend).
- Local/warehouse cache = "the raw data chunks this warehouse recently read" (dies when the warehouse suspends).
- Metadata cache = "quick facts about tables" (row counts, min/max — used for things like COUNT(*) without scanning).
Order: result cache → local cache → remote disk.
🧠 Exam trap: suspending a warehouse clears its local cache, but the result cache is separate (cloud services layer) and survives. So after suspend, an identical query can *still* hit the result cache; but a query needing the raw partitions pays the cold cost again.
### 5. Micro-partitions & Pruning (intro)
- Snowflake stores table data in micro-partitions (small compressed chunks of ~16MB with min/max metadata per column).
- Pruning = *"scanning only the required partitions."* When you filter (e.g. WHERE date = ...), Snowflake uses the per-partition min/max metadata to skip partitions that can't match — so it reads far fewer partitions.
- In the query profile: "partitions scanned / partitions total" — good pruning = scanned ≪ total.
🧠 Pruning = reading only the partitions that could contain your data, skipping the rest. Less data scanned = faster + cheaper. It's automatic, and it's why WHERE filters on well-clustered columns are fast. (Clustering keys — next class — improve pruning.)
### 6. Previewed for next class
Krishna listed these "important" topics coming up:
- QAS = Query Acceleration Service.
- SOS = Search Optimization Service.
- Clustering keys (improve pruning on large tables).
- More on caching durations + micro-partitions in detail.
- ENABLE_QUERY_ACCELERATION on a warehouse was toggled (set FALSE) as setup for the QAS discussion.
### Cheat-sheet / quick recall

*End of Class 30 notes. Topics = directory tables, QUALIFY, 3 caches (result/local/metadata), micro-partitions + pruning intro. Next: QAS, SOS, clustering keys.*
