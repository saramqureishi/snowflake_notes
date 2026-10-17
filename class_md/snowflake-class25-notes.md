# Class 25 — Table Types & Time Travel
## Snowflake — Class 25 Notes
### Table Types & Time Travel (+ a quick SCD Type 2 recap)
Class length: ~62 min. Honest labeling: The first ~15 min re-runs the Class 24 SCD Type 2 procedure (expire old + insert new version) with a fresh salary change — a recap, no new SCD content. The real new material is two big SnowPro-heavy topics: (1) Table Types (permanent, temporary, transient, external, dynamic, iceberg, hybrid) and (2) Time Travel (going back to past data via OFFSET / BEFORE statement / AT timestamp, retention periods, UNDROP, and fail-safe). Transient tables, iceberg creation, and clustering keys are deferred to the next session.
### PART A — SCD Type 2 recap (quick)
Re-demonstrated the Class 24 procedure: a new file arrives where employee 102's salary changed 55,000 → 95,000. Calling the procedure:
1. Expired the existing current row — is_current = FALSE, and set `end_date = today` (the record was valid *from* its effective_date *to* this end_date).
1. Inserted a new current row — is_current = TRUE, `end_date = NULL` (NULL end_date = "still current"), `version = old + 1`.
🧠 The effective_date / end_date pair tells a row's "valid time window": old version = effective_date → end_date; current version = effective_date → NULL. NULL end_date is the universal "this is the live one" signal.

Also recapped: the procedure's two temp tables hold *intermediate* data — one stages the raw file rows, the other holds the de-duplicated (ROW_NUMBER rn=1) rows. Temp tables vanish when the session ends (proven live by logging out/in — they were gone), which saves storage since the data isn't kept permanently.
### PART B1 — Table Types ⭐ (exam-heavy)
Snowflake has several table types. You can identify any table's type from INFORMATION_SCHEMA.TABLES using flag columns:

Example lookups shown in class:
-- permanent tables
SELECT * FROM information_schema.tables
WHERE table_type='BASE TABLE' AND is_transient='NO';

-- transient tables
SELECT * FROM information_schema.tables WHERE is_transient='YES';

-- temporary tables (note the type string)
SELECT * FROM information_schema.tables WHERE table_type='LOCAL TEMPORARY';
Creating them:
CREATE TABLE t_permanent (...);              -- default = permanent
CREATE TRANSIENT TABLE t_transient (...);    -- transient
CREATE TEMPORARY TABLE t_temp (...);         -- temporary (session-scoped)
🧠 The hierarchy to remember (by durability + protection):
- Permanent = full safety net: up to 90 days Time Travel + 7 days Fail-safe. Default.
- Transient = lighter/cheaper: max 1 day Time Travel, NO Fail-safe. For data you can recreate.
- Temporary = session-only, gone at logout, no safety net. For intermediate/scratch data.

Temporary & transient save storage cost precisely *because* they don't keep the long safety-net history that permanent tables do.
### PART B2 — Time Travel ⭐⭐ (very exam-heavy)
Time Travel = query or restore data as it existed in the past. Used mainly for accidental data loss / bad updates — go back to before the mistake.
#### The scenario
A table had 12 good rows. A developer accidentally ran UPDATE test_emp SET salary = ... → all rows wrong. We want the data *as it was before* that update.
#### Three ways to look back
1. OFFSET — go back a relative amount of time
-- go back 4 minutes (60 seconds * 4), as a negative offset
SELECT * FROM test_emp AT (OFFSET => -60*4);
- You keep increasing the minutes until you land *before* the bad update (class walked 4→5→6→…→10 minutes until the good data appeared).
- Negative number = "this many seconds ago."
2. BEFORE (STATEMENT) — go back to just before a specific query ran
-- state of the table immediately BEFORE that update statement executed
SELECT * FROM test_emp BEFORE (STATEMENT => '<query_id_of_the_update>');
- You find the offending query's query_id in QUERY_HISTORY, then view the table as it was *before* it ran. Clean and exact — no guessing minutes.
3. AT (TIMESTAMP) — go back to an exact point in time
SELECT * FROM test_emp AT (TIMESTAMP => '<a specific timestamp>');
-- also: AT (STATEMENT => '<query_id>')  -- state AS OF that statement
- Use the start-time of the bad statement (from QUERY_HISTORY) to see the data at that instant.
Finding how far back to go — use QUERY_HISTORY + DATEDIFF:
-- the bad UPDATE is visible in query history (also get its query_id)
SELECT * FROM TABLE(information_schema.query_history());
-- how long ago did it run?
SELECT DATEDIFF('minute', '<update_start_time>', CURRENT_TIMESTAMP());
#### Restoring the data (not just viewing)
Once you've got the good data via Time Travel, you write it back:
-- option A: snapshot into a backup table
CREATE TABLE t_backup AS
SELECT * FROM test_emp AT (OFFSET => -60*9);

-- option B: MERGE the good values back into the original (by surrogate_key)
MERGE INTO test_emp t
USING (SELECT * FROM test_emp AT (OFFSET => -60*9)) s
    ON t.surrogate_key = s.surrogate_key
WHEN MATCHED THEN UPDATE SET t.salary = s.salary;
#### Retention period controls how far back you can go
- `DATA_RETENTION_TIME_IN_DAYS` sets the Time Travel window.
- Default = 1 day for a permanent table.
- Max = 90 days (permanent). 91 → error: *"exceeds the maximum allowed retention time."*
- Set it to 0 → no Time Travel at all → AT (OFFSET => ...) / BEFORE (STATEMENT => ...) both fail with *"Time travel data is not available ... retention time is 0."* (demonstrated on a DATA_RETENTION_TIME_IN_DAYS = 0 table — unrecoverable via Time Travel).
CREATE TABLE t_fast (...)  DATA_RETENTION_TIME_IN_DAYS = 0;   -- no time travel
CREATE TABLE t_long (...)  DATA_RETENTION_TIME_IN_DAYS = 90;  -- max
🧠 Retention summary: permanent default 1 day, max 90; set 0 = no time travel (can't recover). Check it in the retention_time column of SHOW TABLES / the table listing.
#### UNDROP — restore a dropped table
DROP TABLE test_emp;
UNDROP TABLE test_emp;      -- brings it back (works within the retention window)
- Works only if retention > 0. On a retention = 0 table, UNDROP fails: *"table does not exist / purged."*
The "dropped then recreated with the same name" trick: if a table was dropped and a new table with the *same name* already exists, UNDROP errors *"object already exists."* Fix: rename the current one first, then UNDROP:
ALTER TABLE raw_test_emp RENAME TO raw_test_emp_old;
UNDROP TABLE raw_test_emp;    -- now the old version comes back cleanly
#### Fail-safe (vs Time Travel)
- After Time Travel expires, a permanent table gets 7 days of Fail-safe.
- Difference:
- Time Travel = *you* (developer/admin) can recover with SQL (AT, BEFORE, UNDROP).
- Fail-safe = *only Snowflake / the cloud provider* can recover it, by request — you can't SQL into it.
- So the full protection for a permanent table = 90 days Time Travel + 7 days Fail-safe. Transient/temporary have no Fail-safe.
🧠 One-line mental model: *Time Travel = self-service recovery you control; Fail-safe = Snowflake's last-resort backup you can't touch directly.*
### PART C — Previewed for next class
- Transient tables in depth (session-ish scope, no time travel/fail-safe nuance).
- Iceberg tables creation (not possible on trial).
- Clustering keys.
- More Time Travel cases (all of OFFSET / STATEMENT / TIMESTAMP together).
### Cheat-sheet / quick recall

*End of Class 25 notes. Topics = table types + Time Travel (OFFSET/BEFORE/AT, retention, UNDROP, fail-safe). Next: transient tables, iceberg, clustering keys, more time-travel cases.*

