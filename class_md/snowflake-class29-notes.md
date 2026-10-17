# Class 29 — Hybrid Tables, Secure Views & Dynamic Tables
## Snowflake — Class 29 Notes
### Snowflake-managed Iceberg · Hybrid Tables · Views (Secure) · Dynamic Tables
Class length: ~66 min. Honest labeling: This class wraps up the table types topic and covers several distinct things: (1) Snowflake-managed iceberg (vs external-volume iceberg), (2) Hybrid tables (concept only — not creatable on trial accounts), (3) Views + Secure views (recap + new secure-view detail), and (4) the big new topic: Dynamic Tables (target lag, auto-refresh, incremental refresh — done hands-on). Materialized views + the dynamic-vs-materialized difference are previewed for next class.
### 1. Iceberg: External Volume vs Snowflake-managed
Recap of iceberg's two parameters (EXTERNAL_VOLUME + BASE_LOCATION), then a new distinction:

-- Snowflake-managed iceberg (no base_location needed)
CREATE ICEBERG TABLE t_ib_sf_managed (...)
    CATALOG = 'SNOWFLAKE'
    EXTERNAL_VOLUME = 'SNOWFLAKE';   -- Snowflake manages the storage internally
🧠 The trade-off: external-volume iceberg = data in *your* cloud (no Snowflake storage cost, other engines can read it). Snowflake-managed iceberg = Snowflake handles everything internally (you pay storage, can't see the files, but zero setup). Use external volume when multiple teams/engines need the same data without connecting to Snowflake.
Recap of the metadata files (from Class 28): data = Parquet; metadata = JSON + Avro. The Avro files tell Snowflake which JSON metadata file to read (one snap- Avro = snapshot list, one without snap = manifest). Multiple JSONs exist; the Avro points to the latest.
### 2. Hybrid Tables ⭐ (concept only — not on trial)
- Identify: is_hybrid = 'YES' in INFORMATION_SCHEMA.TABLES.
- Cannot be created on a trial account (needs an enterprise/paid account) — Krishna showed the error: *"Hybrid tables are currently not available in trial accounts."*
- Main purpose: enforce a PRIMARY KEY — no duplicates, no NULLs in the key column.
- Requires a primary key defined at creation (fails without one).
#### The key insight: normal tables DON'T enforce primary keys ⭐⭐
This is a classic exam gotcha, demonstrated live:
- You can add a PRIMARY KEY constraint to a normal (permanent) table, but Snowflake does NOT enforce it — you can still insert duplicates and NULLs!
- Check with INFORMATION_SCHEMA.TABLE_CONSTRAINTS → the `ENFORCED` column shows `NO` for a normal table's PK.
- Only hybrid tables actually enforce the primary key (reject duplicates/NULLs).
-- on a normal table, this constraint is NOT enforced
ALTER TABLE customer ADD CONSTRAINT pk PRIMARY KEY (id);
-- you can still insert duplicate ids and NULL ids! (ENFORCED = NO)
🧠 The exam fact: in Snowflake, primary key / unique constraints on normal tables are metadata-only — NOT enforced. They document intent but don't block bad data. Hybrid tables are the exception — they enforce PK (for OLTP/master-data use cases where uniqueness matters). This is why you'd use a hybrid table to maintain master data.
### 3. Views (recap) + Secure Views (new) ⭐
#### Normal views (recap)
- A view = a saved query. Stores no data → no storage cost.
- Every time you query a view, it re-runs the underlying statement (hits the base tables each time).
- Use to: derive extra columns, join tables, restrict columns, give access without exposing base tables.
- Grant a view to a role so a user can see *derived* data without access to the underlying tables — demonstrated: a MANAGER role with no table grants could still query the view.
#### Secure Views ⭐⭐ (the new concept)
- Problem: with a normal view, a user can run SHOW VIEWS and see the `text` column = the view's full SQL definition (the underlying query, table names, logic). That leaks your logic.
- Fix: create a SECURE VIEW → the definition is hidden.
CREATE SECURE VIEW sv_ind_customers AS
SELECT ... ;
- After this: SHOW VIEWS → the text column is blank for secure views, and IS_SECURE = TRUE.
🧠 Normal view = anyone granted it can see your SQL (`text` column). Secure view = SQL hidden. Use secure views when the query logic itself is sensitive (or to prevent users from seeing table structure they shouldn't). There's also a performance/security aspect: secure views don't expose data via query optimization side-channels.
(Also mentioned: IS_MATERIALIZED column — materialized views covered next class.)
### 4. Dynamic Tables ⭐⭐⭐ (the big new topic — hands-on)
#### The problem dynamic tables solve
A normal view re-runs its query every single time you select from it. If you query it 100 times, it hits the base tables 100 times — even if the data never changed. That's wasted compute, especially for expensive multi-table joins.
Dynamic table = a table that automatically refreshes itself on a schedule, storing the result. It only does work when the underlying data actually changes.
#### Creating a dynamic table
CREATE DYNAMIC TABLE t_dy_cust_info
    TARGET_LAG = '2 minutes'          -- how fresh the data must be (refresh frequency)
    WAREHOUSE = dev_warehouse         -- compute to run the refresh
AS
    SELECT c.c_custkey, c.c_name, n.n_name
    FROM customer c
    JOIN nation n ON c.c_nationkey = n.n_nationkey
    WHERE n.n_nationkey = 8;
The two key parameters:
- `TARGET_LAG` = how "stale" the data is allowed to be. '2 minutes' → Snowflake refreshes it so it's never more than 2 minutes behind the source. (Can also be DOWNSTREAM.)
- `WAREHOUSE` = the compute used to run the refresh (needed because refreshing = running the query).
#### How it behaves (demonstrated live)
- First refresh: loads all rows (e.g. "number of rows inserted: 604").
- Every TARGET_LAG interval: checks for changes.
- No change → refresh says "no data" (nothing inserted/updated/deleted).
- Change in source → the dynamic table auto-updates to match.
- It acts like a normal table (stores data, you query it directly), but self-maintains.
#### Watching it work
-- see refresh history
SELECT * FROM TABLE(information_schema.dynamic_table_refresh_history(
    NAME => 'T_DY_CUST_INFO'));
Demonstrated:
- Deleted a nation row → after the lag, the dynamic table refreshed and the matching rows disappeared (refresh showed "deleted rows").
- Inserted a nation row → after the lag, the dynamic table refreshed and new rows appeared (refresh showed "inserted rows").
- The refresh history also shows `incremental` vs full refresh — Snowflake does incremental refreshes (only processes what changed), which is efficient.
#### Use case
🧠 Dynamic table = a "live, auto-refreshing view that stores its result." Best when you join multiple tables and want the result kept fresh automatically without manually re-running or scheduling tasks. Snowflake handles the refresh logic + does it incrementally.
#### Dynamic table vs CDC (student question)
- CDC (streams) = captures *every* change (insert/update/delete) on a table for you to process (Class 11).
- Dynamic table = declaratively keeps a *query result* fresh (joins, filters, derived data). Different purpose — dynamic tables aren't a replacement for streams/CDC.
### 5. Previewed for next class
- Hybrid tables demo (on a proper account — not trial).
- Materialized views + the difference between dynamic tables and materialized views (both store results; different refresh/use models).
### Cheat-sheet / quick recall

*End of Class 29 notes. Topics = SF-managed iceberg, hybrid tables (PK enforcement), secure views, dynamic tables (target lag/incremental refresh). Next: hybrid table demo + materialized views vs dynamic tables.*

