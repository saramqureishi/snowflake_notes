# Class 24 — Full SCD Type 2 Procedure
## Snowflake — Class 24 Notes
### SCD Type 2 — the full implementation inside a stored procedure (+ de-duplication with ROW_NUMBER)
Class length: ~60 min. Honest labeling: This class is the direct continuation of Class 23 — it takes the hash-based change-detection idea and turns it into a complete, automated SCD Type 2 stored procedure. New material vs Class 23: (1) the MERGE to expire old records, (2) wrapping the whole full-load + SCD-2 flow in a procedure that takes a `file_name` parameter, (3) de-duplication with `ROW_NUMBER()`, and (4) a proper set of audit/ETL columns (surrogate key, effective/end dates, is_current, version, is_deleted). The class first *re-does Class 23 manually* (because a fresh account was created), then builds the procedure. One more scenario (likely soft delete) is deferred to the next session.

Account/objects: source EMP, target TARGET_EMP, view VW_EMP — same family as Class 23.
### 0. Recap of where we are (Class 23 → 24)
From Class 23 you already know:
- `hash_key` = hash of the primary key → identifies a row (WHO)
- `hash_data` = hash of all columns → fingerprint of contents (WHAT)
- Changed row = hash_key matches but hash_data differs
- New row = hash_key not in target (NOT EXISTS)
- SCD Type 2 = keep history: expire the old row (flag it), insert the new row as current
Class 24 automates all of that into one procedure, and adds the production details that make it real.
### 1. The manual walk-through (first half of class)
Because a new account was created, Krishna re-built the Class 23 objects and re-did the detection manually before automating. The manual steps, in order:
1. Source `EMP` (10 rows), target `TARGET_EMP` (empty, has hash_key + hash_data + the other columns), and view `VW_EMP` that computes hash_key/hash_data from the source.
1. Full load: INSERT INTO target_emp SELECT * FROM vw_emp; (first time, target empty).
1. New row detection with NOT EXISTS → insert the new row.
1. Changed row detection with EXISTS (... t.hash_key=s.hash_key AND t.hash_data <> s.hash_data).
1. The SCD Type 2 move — two actions:
- Expire the existing row: UPDATE/MERGE the matching active row → active_flag = 'N' (it becomes the *old* record, but is kept).
- Insert the new values as a fresh row → active_flag = 'Y' (the current record).
- Result: two rows for employee 10 — old salary 20,000 (N) + new salary 75,000 (Y). History preserved.
🧠 Key sequencing rule: when a row changes, you expire first, then insert. Update the old row's flag to N/false, *then* insert the new version as Y/true. Never overwrite in place — that would lose history (that'd be SCD Type 1).
#### The MERGE to expire old records
Instead of a plain UPDATE, the class used a MERGE to flip the flag on changed rows:
MERGE INTO target_emp t
USING vw_emp s
    ON  t.hash_key  = s.hash_key          -- same employee
    AND t.hash_data <> s.hash_data         -- but content changed
WHEN MATCHED THEN
    UPDATE SET t.active_flag = 'N';        -- expire the old record
Then the new version is inserted separately with active_flag = 'Y':
INSERT INTO target_emp (... , active_flag)
SELECT ... , 'Y'
FROM vw_emp s
WHERE EXISTS (SELECT 1 FROM target_emp t
              WHERE t.hash_key = s.hash_key AND t.hash_data <> s.hash_data);
### 2. The audit / ETL columns (production target table)
A real SCD Type 2 target table isn't just the business columns — it carries metadata columns that track history. The class's TARGET_EMP had:

🧠 Why so many columns? SCD Type 2 is about *history and lineage*. effective_date/end_date tell you the time window a version was valid; is_current lets you quickly filter "the row as it is now"; version numbers the changes; file_name/load_date give you traceability back to the source file. These are standard ETL audit columns in a data warehouse.
#### Surrogate key = auto-increment
sk NUMBER AUTOINCREMENT,     -- Snowflake fills this in automatically on insert
A surrogate key is a system-generated unique id for each physical row — it's *not* the business key (empno). Because SCD Type 2 stores the *same* empno multiple times (one per version), you need a separate surrogate key to uniquely identify each physical row.
### 3. Wrapping it in a PROCEDURE (the automation)
The whole flow was moved into a stored procedure that takes the `file_name` as an input parameter. High-level shape:
CREATE OR REPLACE PROCEDURE pr_scd2_load(p_file_name VARCHAR)
RETURNS VARCHAR
LANGUAGE SQL
AS
$$
    DECLARE
        -- temp tables / variables
    BEGIN
        -- STEP 1: load this file's rows from the view into a TEMP table
        -- STEP 2: de-duplicate (ROW_NUMBER) into a clean TEMP table
        -- STEP 3: expire changed rows in target (MERGE → is_current = FALSE)
        -- STEP 4: insert new + changed rows as current (is_current = TRUE)
        RETURN 'success';
    END;
$$;
Call it by passing the file you want to process:
CALL pr_scd2_load('Cust_Info_F_20261005.csv');
🧠 Why pass the file name? The procedure processes one file's worth of data at a time. The file_name lets it (a) filter the view to just that file's rows, and (b) record lineage (file_name column) so you know which file produced each row.
### 4. De-duplication with `ROW_NUMBER()` ⭐ (the new concept)
The problem: a source file might contain duplicate rows (same hash_key twice). You must NOT load duplicates into the target. So before loading, you de-duplicate.
The tool: ROW_NUMBER() — a window function that numbers rows *within groups*.
SELECT *,
       ROW_NUMBER() OVER (
           PARTITION BY hash_key              -- group rows by the key
           ORDER BY load_date, file_name      -- decide which copy is "first"
       ) AS rn
FROM temp_emp_all;
- `PARTITION BY hash_key` → "restart counting for each distinct key." So all rows with the same key form a group.
- `ORDER BY ...` → within each group, decide which copy is #1 (e.g. by load date).
- `ROW_NUMBER()` → assigns 1, 2, 3… inside each group.
Then keep only the first copy of each key:
-- only unique rows (rn = 1) move forward
INSERT INTO temp_emp_dedup
SELECT ... FROM (that query) WHERE rn = 1;
- rn = 1 → the one row to keep per key.
- rn = 2 (or more) → duplicates, excluded.
Demo: 10 rows + 1 deliberately-inserted duplicate of key 101 = 11 rows in the raw temp table. After ROW_NUMBER filtering (rn = 1), the duplicate (rn = 2) is dropped → back to 10 unique rows, which then load to target.
🧠 The pattern to remember: *de-dup = ROW_NUMBER() OVER (PARTITION BY key ORDER BY something) then keep rn = 1.* This is the standard way to drop duplicates in Snowflake/SQL — not just here, but everywhere.
### 5. The two temp tables inside the procedure

The dedup temp table is what feeds the expire-and-insert SCD Type 2 logic against TARGET_EMP.
### 6. Running the procedure — what you observe
Full-load run (target empty): call the procedure → all 10 unique rows land in TARGET_EMP, each is_current = TRUE, version = 1. (The injected duplicate was dropped by de-dup.)
Change run (employee 101's salary changes, delivered in a new file):
1. Procedure runs → finds hash_key 101 matches but hash_data differs → change detected.
1. Expires the old 101 row: is_current = FALSE (its end_date set).
1. Inserts the new 101 row: is_current = TRUE, version = 2, new effective_date.
1. Result: two rows for 101 — old (salary 65,000, is_current = FALSE, version 1) + new (salary 200,000, is_current = TRUE, version 2). The version and is_current columns both flip exactly as expected.
🧠 How to query "current state": WHERE is_current = TRUE (or active_flag='Y') gives you the latest version of every row. Drop that filter to see full history including all past versions.
### 7. Previewed for NEXT class
One more SCD scenario deferred to the next session — most likely soft delete (the is_deleted / ETL_IS_DELETED column that was added to the table but not yet used): handling rows that *disappear* from the source by flagging them deleted rather than physically removing them. Krishna also said he'd share the notes/code, and asked everyone to practice replicating the full procedure since it takes time to absorb.
### 8. Cheat-sheet / quick recall

*End of Class 24 notes. Topic = full SCD Type 2 stored procedure (expire + insert), ROW_NUMBER de-duplication, audit columns, file-name-driven loads. Next: one more scenario (likely soft delete via is_deleted).*

