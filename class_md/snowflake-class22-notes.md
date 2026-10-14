# Class 22 — Exception Handling in Procedures
## Snowflake — Class 22 Notes
### Exception Handling in Stored Procedures (+ a COPY idempotency lesson)
Class length: ~59 min. Honest labeling: Despite following the UDF class, Class 22 is almost entirely about EXCEPTION handling inside stored procedures — it builds on the Class 16–20 procedure/cursor work, NOT on UDFs. The one detour is a very useful COPY INTO "why won't it reload my file?" → `FORCE=TRUE` / TRUNCATE vs DELETE lesson that surfaced while demoing a COPY inside a procedure. The class ends by previewing the next class: Full load / Incremental / SCD Type 2 using procedures.

Account used in class: HDFC demo account — hdfc_db / banking_schema / hdfc_Wh, role accountadmin. The working table is `EMP` (the classic 14-row Oracle-style emp table, extended with DOR, GRATUITY, DESCRIPTION columns from Classes 17–20).
### 0. Where this sits in the story
- Classes 16–20: stored procedures — variables, SELECT INTO, IF/ELSEIF, OBJECT_CONSTRUCT for debugging, cursors, EXECUTE AS OWNER/CALLER, RESULTSET table procs.
- Class 21: UDFs (functions).
- Class 22 (this one): the EXCEPTION section of a procedure — how to catch and handle errors gracefully instead of letting the procedure blow up.
The instructor reused the gratuity cursor procedure (PR_GRATUITY_UPDATE_cursor) from Class 20 as the sandbox for all the exception experiments.
### 1. The big idea: two kinds of exceptions
An exception = an error that happens while a procedure runs. Snowflake gives you an EXCEPTION section to *catch* those errors and respond, instead of the whole procedure failing with a raw error.
Two families:

🧠 Core distinction to remember: a *predefined* exception is Snowflake saying "this is broken" (bad SQL, bad data type). A *user-defined* exception is you saying "this violates my business rule" even though Snowflake would happily run it.
### 2. The structure of a procedure (with exceptions)
CREATE OR REPLACE PROCEDURE pr_name(...)
RETURNS <type>
LANGUAGE SQL
AS
$$
    DECLARE
        -- variables, cursors, AND user-defined exceptions declared here
        v_sal NUMBER;
        exp_sal_check EXCEPTION;                 -- user-defined exception
    BEGIN
        -- normal work: SELECT INTO, DML, loops, IF, RAISE ...
    EXCEPTION
        -- handlers go here
        WHEN exp_sal_check THEN ... ;
        WHEN statement_error THEN ... ;
        WHEN other THEN ... ;                    -- OTHER must be LAST
    END;
$$;
- DECLARE — declare variables, cursors, and any user-defined exceptions.
- BEGIN ... (EXCEPTION) ... END — the body, then the handlers.
### 3. User-defined exceptions — the `salary < 1000` example
Scenario: business rule says an employee's salary must be at least 1000. If it's lower, *that's an error* — even though Snowflake would store it fine.
#### Three building blocks
1. Declare the exception (in DECLARE):
   exp_sal_check EXCEPTION;
1. Raise it when your condition is violated (in BEGIN):
   IF (v_sal < 1000) THEN
       RAISE exp_sal_check;
   END IF;
1. Handle it (in EXCEPTION):
   EXCEPTION
       WHEN exp_sal_check THEN
           LET v_exp_message VARCHAR;
           v_exp_message := 'salary is less than 1000';
           RETURN v_exp_message;
🧠 Flow to remember: the moment RAISE fires, execution jumps straight to the EXCEPTION section, finds the matching WHEN, runs that handler, and the procedure ends there. It does *not* continue the normal body.
#### Adding a custom error code + message
You can declare the exception with a number and a message:
exp_sal_check EXCEPTION (-20002, 'Salary is less than 1000');
- The number must be in Snowflake's user range: `-20000` to `-20999`. (Reserved range for developer-defined errors.)
- Then in the handler you can return Snowflake's built-in columns `SQLCODE` and `SQLERRM`:
  WHEN exp_sal_check THEN
      RETURN CONCAT(SQLCODE, '-------', SQLERRM);
  -- → e.g. "-20002-------Salary is less than 1000"
#### ⚠️ The gotcha about SQLCODE / SQLERRM
- SQLCODE and SQLERRM are **auto-populated for *predefined* exceptions**.
- For a user-defined exception they are NULL by default — *unless you supply the (-20002, 'message')* when declaring the exception. That's exactly why you pass those two values: so your custom error carries a meaningful code + message.
### 4. The three predefined exceptions
The instructor triggered each one on purpose, so you learn to recognise them:

Handling them looks like:
EXCEPTION
    WHEN statement_error  THEN RETURN CONCAT(SQLCODE, '------', SQLERRM);
    WHEN expression_error THEN RETURN CONCAT(SQLCODE, '------', SQLERRM);
    WHEN other            THEN RETURN CONCAT(SQLCODE, '------', SQLERRM);
For predefined exceptions, SQLCODE/SQLERRM fill in automatically — so you get the real Snowflake error number + text.
### 5. `OTHER` — the catch-all, and the #1 rule
- OTHER handles *any* exception type** — statement, expression, or anything else.
- Best practice: every procedure in real projects includes a WHEN other THEN ... handler, so nothing escapes unhandled.
- 🚨 Hard rule: **OTHER must be the *last* handler.** If you put it first, Snowflake refuses to create the procedure: *"OTHER must be the last handler."*
🧠 Why name specific exceptions at all if `OTHER` catches everything? Because specific handlers tell you *what kind* of problem it was. A student asked exactly this. Krishna's answer: if you add a label like RETURN CONCAT('statement', ...) vs CONCAT('expression', ...), you instantly know whether the bug is in your SELECT (statement) or your data types (expression) — without that, OTHER alone tells you *something* broke but not *which category*. So: name the ones you expect, keep OTHER last as the safety net.
🧠 Memory hook: *"Specific handlers first for diagnosis; OTHER last as the safety net."*
### 6. Bonus lesson: COPY INTO inside a procedure → the FORCE / TRUNCATE story
While demoing "can I put a COPY INTO inside a procedure?" (yes you can), a very practical issue surfaced. The procedure loaded EMP from a staged CSV (@stg_csv_stage/test_emp.csv), and on re-run it loaded 0 rows. This is one of the most useful real-world lessons in the class:
#### Why COPY sometimes loads 0 files
- COPY INTO remembers which files it has already loaded (load metadata). If you COPY the *same file name* again, Snowflake skips it → "0 files processed" — even if the table is now empty.
- You can see this history with:
  SELECT * FROM TABLE(information_schema.copy_history(
      table_name=>'EMP',
      start_time=>DATEADD('hours',-1,current_timestamp())));
#### Two ways to force a reload
1. `FORCE = TRUE` — reload the file even though it was loaded before:
   COPY INTO emp FROM (SELECT $1..$11 FROM @stg_csv_stage/test_emp.csv (file_format=>csv_format)) FORCE=TRUE;
1. TRUNCATE the table instead of DELETE — this is the key difference:

🧠 The lesson in one line: *DELETE empties the table but COPY still remembers the file; TRUNCATE wipes both the rows and the load history, so a re-COPY works.* For a "truncate-and-load" pattern inside a procedure, use TRUNCATE TABLE then COPY INTO.
The final version of the procedure wrapped this safely:
BEGIN
    TRUNCATE TABLE emp;
    COPY INTO emp FROM (SELECT $1,$2,...,$11
        FROM @stg_csv_stage/test_emp.csv (file_format=>csv_format));
    -- ... then the cursor loop computing gratuity ...
EXCEPTION
    WHEN statement_error  THEN RETURN CONCAT(SQLCODE,'------',SQLERRM);
    WHEN expression_error THEN RETURN CONCAT(SQLCODE,'------',SQLERRM);
    WHEN other            THEN RETURN CONCAT(SQLCODE,'------',SQLERRM);
END;
### 7. Previewed for NEXT class (Class 23)
"Tomorrow's session is very important" — Krishna. Next class = implementing, via stored procedures:
- Full load
- Incremental load
- SCD Type 2 (slowly changing dimensions)

(You said you'll hand me Class 23 after we finish the Class 22 hands-on. 👍)
### 8. Cheat-sheet / quick recall

*End of Class 22 notes. Topic = exception handling (+ COPY FORCE/TRUNCATE). Next: Class 22 hands-on in the HDFC account, then Class 23 (Full load / Incremental / SCD Type 2).*

