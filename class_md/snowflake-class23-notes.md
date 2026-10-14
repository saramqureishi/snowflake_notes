# Class 23 — Change Detection & SCD Type 2 (basics)
## Snowflake — Class 23 Notes
### Full Load, Change Detection & SCD Type 2 — the HASH KEY / HASH DATA pattern
Class length: ~62 min. Honest labeling: This class is the conceptual foundation for Full Load / Incremental / SCD Type 2 using hash columns. It's heavily hands-on building up the idea piece by piece, but the complete SCD Type 2 implementation is deferred to the next (Monday) session — Krishna explicitly says so at the end, and also notes there's no class the next day (he's attending a GenAI/agentic-AI event on Oct 3–4). So this class = "understand hash_key & hash_data and why we need them"; the full merge logic comes next.

Account used: HDFC demo (hdfc_db / banking_schema). Working table: `EMP` (name, salary, location, designation, etc.). Target: `TARGET_EMP`, plus a view `VW_EMP`.
### 0. The problem this class solves
In data engineering you repeatedly move data from a source into a target table. Three classic patterns:
- Full load — wipe target, reload everything.
- Incremental load — only move *new* or *changed* rows.
- SCD Type 2 (Slowly Changing Dimension) — keep history: when a row changes, don't overwrite it — mark the old one inactive and insert a new "current" version.
To do incremental/SCD well, you need to answer two questions fast, across millions of rows:
1. Is this row new? (not in target yet)
1. Did this row change? (same key, but some column differs)
Comparing every column one-by-one is slow and messy. The trick: hash columns. That's the whole point of this class.
### 1. The two hash columns (the heart of the pattern)

🧠 The core idea: hash_key identifies the row; hash_data is a fingerprint of the whole row's contents. If two rows have the same `hash_key` but different `hash_data`, the row changed. If a hash_key exists in source but not in target, it's a new row. Comparing two short hash strings is far simpler than comparing every column.
#### Hash functions
- `MD5(string)` → a fixed unique-ish value for the input string. Same input → same hash every time; different input → different hash.
- Demo: SELECT MD5('krishna') and SELECT MD5('krishnA') give different hashes (case-sensitive). Re-running MD5('krishna') gives the same hash — that's determinism, exactly what we need.
- `SHA2(string)` → alternative, stronger hash. You can use either `MD5` or `SHA2` for the same purpose. Both appear in real projects.
### 2. Building `hash_key` from the primary key (and the NULL trap)
Start simple — hash the primary key:
SELECT empno, MD5(empno) AS hash_key FROM emp;
This gives a unique value per empno. But what if `empno` is NULL? Two problems:
1. Hashing a NULL gives NULL (useless as a key).
1. MD5 expects a string; a NULL number can misbehave.
#### The fix: `NVL` + cast to VARCHAR
- `NVL(value, replacement)` (same idea as COALESCE) → "if value is NULL, use the replacement instead."
- Cast the number to text first with `::VARCHAR` (the :: is the cast operator), because NVL(empno, 'NULL') would fail if empno is a number and the replacement is a character.
-- robust key hash: treat empno as text, and if NULL substitute the word 'NULL'
SELECT MD5(NVL(empno::VARCHAR, 'NULL')) AS hash_key FROM emp;
🧠 Why this matters: a primary key should never be NULL or duplicated. Wrapping with NVL(... ::VARCHAR, 'NULL') makes the hashing *safe* even if dirty data shows up, instead of blowing up or producing NULL keys.
### 3. Building `hash_data` — concatenate ALL columns, then hash
For the content fingerprint, we glue every column together into one string (with a separator) and hash that.
#### Concatenation: `CONCAT` vs `||` (double-pipe)
Two equivalent ways to join strings:
SELECT CONCAT('My name is ', 'Krishna');   -- function form
SELECT 'My name is ' || 'Krishna';         -- || is the concatenation operator
🧠 Both do the same thing. || ("double-pipe") is the classic SQL concat operator (from Oracle days); CONCAT is the newer function. Snowflake supports both — use whichever you like.
#### Why a pipe `|` separator between columns?
We put a literal `|` between each column value when concatenating. This prevents false matches: without a separator, 12 + 3 and 1 + 23 would both become 123. The | keeps field boundaries distinct → 12|3 vs 1|23.
-- fingerprint of the whole row (NULL-safe + separated), hashed
SELECT
    MD5(
        NVL(empno::VARCHAR,'NULL')  || '|' ||
        NVL(ename,'NULL')           || '|' ||
        NVL(sal::VARCHAR,'NULL')    || '|' ||
        NVL(location,'NULL')        || '|' ||
        NVL(designation,'NULL')
    ) AS hash_data
FROM emp;
(The same can be done with SHA2(...) instead of MD5(...).) Each column is NULL-protected with NVL(... ,'NULL') and separated with |.
🧠 Lock this in: hash_data = MD5/SHA2( col1 |'|'| col2 |'|'| ... ) with every column NULL-handled. Change *any* column's value → the concatenated string changes → the hash changes → you've detected a change.
A student asked: *does it load row-by-row or bulk, and how does uniqueness work?* → The hash is computed per row as part of the SELECT/view, so each row gets its own fingerprint regardless of bulk loading. The uniqueness comes from the hash of that row's values, not from the load mechanism.
### 4. The VIEW that adds the hash columns
The source EMP table doesn't physically store hash_key/hash_data — instead we build a view on top of it that *computes* them. That way the raw table stays clean and the hashes are always derived fresh.
CREATE OR REPLACE VIEW vw_emp AS
SELECT
    emp.*,
    MD5(NVL(empno::VARCHAR,'NULL'))                         AS hash_key,
    MD5(
        NVL(empno::VARCHAR,'NULL') || '|' || NVL(ename,'NULL') || '|' ||
        NVL(sal::VARCHAR,'NULL')   || '|' || NVL(location,'NULL') || '|' ||
        NVL(designation,'NULL')
    )                                                        AS hash_data
FROM emp;
🧠 Why a view (not a table)? The source file lands in EMP (e.g. via COPY from S3). The view derives hash_key + hash_data on the fly, so you always compare against the *current* source without maintaining extra stored columns. "I received a file, data is loaded, then I create a view to populate those two columns."
### 5. Full load (the easy baseline)
For the very first load, the target is empty, so just copy everything in:
INSERT INTO target_emp
SELECT * FROM vw_emp;        -- (or FROM emp, if target has no hash cols)
That's a full load — straightforward because there's nothing to compare against yet.
### 6. Change detection — the three questions, in SQL
Once the target has data, you compare source (`vw_emp`, aliased `s`) against target (`target_emp`, aliased `t`) using the hash columns.
#### (a) Rows that CHANGED — same key, different fingerprint
SELECT s.*
FROM vw_emp s
WHERE EXISTS (
    SELECT 1 FROM target_emp t
    WHERE t.hash_key = s.hash_key        -- same business row (key matches)
      AND t.hash_data <> s.hash_data     -- but contents differ → CHANGED
);
- WHERE EXISTS (...) → "keep the source row only if a matching target row exists."
- t.hash_key = s.hash_key → it's the same employee.
- t.hash_data <> s.hash_data → something changed (demo: an employee's designation went Clerk → Manager, so the hashes differed and the row was returned).
- If you used = instead of <>, you'd get the *unchanged* rows — the opposite.
#### (b) Rows that are NEW — key not in target at all
SELECT s.*
FROM vw_emp s
WHERE NOT EXISTS (
    SELECT 1 FROM target_emp t
    WHERE t.hash_key = s.hash_key        -- no matching key in target → NEW row
);
- NOT EXISTS → "keep source rows whose key is not found in target." (Demo: new employee empno=20, Ravi appeared only in source → returned as new.)
🧠 The pattern in one breath: *EXISTS + hash_data <> = changed rows; NOT EXISTS = new rows.* Two tiny hash comparisons answer "what's new?" and "what changed?" across the whole table.
### 7. SCD Type 2 — the preview (full code = next class)
SCD Type 2 = keep history. When a row changes, you do NOT overwrite the old value. Instead:
1. Keep the existing row, but mark it inactive — set an `active_flag = 'N'` (and typically an end-date).
1. Insert a new row with the updated values and `active_flag = 'Y'` (the current version).
So after a designation change you'd have two rows for that employee:

🧠 SCD Type 2 = "never lose history." Old record flagged N, new record inserted as Y. Contrast with SCD Type 1 (just overwrite, no history). The hash columns from this class are what *trigger* this: hash_data mismatch → a change happened → do the flag-flip + insert.
Deferred: the actual UPDATE old to 'N' + INSERT new as 'Y' merge logic is the next (Monday) session. This class only established *why* we need hash_key/hash_data and how to detect new vs changed rows.
### 8. Cheat-sheet / quick recall

*End of Class 23 notes. Topic = hash-based change detection + Full load + SCD Type 2 intro. Full SCD Type 2 merge code is next (Monday) session. No class on the day after (instructor at a GenAI event).*

