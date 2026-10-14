# Class 21 — User-Defined Functions (UDFs)
## Snowflake — Class 21 Notes
### User-Defined Functions (UDFs): Scalar vs Tabular, Email Normalizer, Risk Classifier, JSON/VARIANT
Class length: ~1 hr 4 min. Honest labeling: This class is mostly teaching + live demo by Krishna. It opens with a short recap of the Class 20 RESULTSET table procedure, then spends the bulk of the time introducing User-Defined Functions (UDFs) with several worked examples. The last ~5 minutes previews functions for the next class (phone masking, calculate_discount, divide-by-zero guards) — those are next class, not covered here.
### 0. Recap from Class 20 — returning a table from a procedure (RESULTSET)
Before starting UDFs, Krishna re-ran the Class 20 example to settle it:
- Goal: a stored procedure that returns a result set as a table.
- Key pieces of that procedure:
- RETURNS TABLE(...) — you declare the columns + data types the proc returns. Column names can be anything; the data types must match what the query produces.
- Declare a variable of type `RESULTSET` — this is the special variable type that *holds a query's result set*.
- Declare a string variable holding the SELECT statement, built dynamically with `CONCAT()` so the input parameter (e.g. department number) gets stitched in.
- `EXECUTE IMMEDIATE` runs a dynamically-built SQL string. Assign its output to the RESULTSET variable: res := (EXECUTE IMMEDIATE :sql);
- Finally RETURN TABLE(res); — note the `TABLE(...)` wrapper is required both in RETURNS TABLE(...) and in RETURN TABLE(res).
- Run it with `CALL proc_name(30);` → output comes back as a tabular result.
- You can also run the same logic inline as an anonymous block (DECLARE ... BEGIN ... END;) — but that's a one-time execution. A procedure is reusable: once created, you just CALL it. That's the advantage of a procedure over an anonymous block.
🧠 Remember it this way: EXECUTE IMMEDIATE = "run this SQL string I just built." You need it whenever the SQL is assembled on the fly (dynamic SQL).
### 1. The big idea: Scalar vs Tabular functions
Snowflake ships built-in functions. They come in two shapes:

Live demo of each:
- Scalar: SELECT CURRENT_DATE(); → one date. SELECT DATEDIFF('year', '2018-01-01', CURRENT_DATE()); → one number (difference in years). One value out = scalar.
- Tabular: SELECT * FROM TABLE(QUERY_HISTORY()); → returns many rows/columns (a table). QUERY_HISTORY takes no parameter; TASK_HISTORY('task_name') takes the task name as a parameter.
- 🔎 Side note from the demo: TASK_HISTORY returned nothing for some tasks because those tasks had never run / were newly resumed. Krishna checked with SHOW TASKS;, saw a task was still in started state, and suspended it with ALTER TASK <name> SUSPEND;. (This is just housekeeping, not the UDF topic.)
🧠 The anchor to remember: *"Table functions wrap in TABLE()."* QUERY_HISTORY, TASK_HISTORY, COPY_HISTORY are the ones you already met — those were your first tabular functions.
### 2. What a UDF is, and why it exists
A UDF (User-Defined Function) is simply your own function, built the same way Snowflake builds its own. If Snowflake gives you QUERY_HISTORY, you can build fn_days_left or get_transaction_risk on the same pattern.
Why bother when built-ins exist?
- Built-ins cover generic things. But your business has its own rules — "a transaction over 10,000 to certain countries is high risk," "emails must be lowercased before matching." You wrap *those business validations* into a UDF, then reuse it everywhere in SELECTs.
Function vs Procedure — the distinction that matters:

🧠 One-line memory hook: *A function goes inside a SELECT and returns something; a procedure is run with CALL and does something.* You can't CALL a function.
Naming convention used in the course: prefix with `fn_` (e.g. fn_days_left). Not required by Snowflake — just the team's convention.
SQL scalar UDF body is an EXPRESSION, not a program. This is the gotcha the instructor hit live:
- A SQL scalar UDF body is just an expression — no `BEGIN`/`END`, no `RETURN` keyword, no procedural statements. When Krishna first wrote it with BEGIN ... RETURN ... END, creation failed; removing them fixed it.
- The general shape:
  CREATE OR REPLACE FUNCTION fn_name(param TYPE)
  RETURNS <return_type>
  AS
  $$
      <a single SQL expression that produces the return value>
  $$;
Languages: A UDF can be written in SQL (default), Python, JavaScript, or Java.
- Student Q: "How does Snowflake know which language?" → You state it with `LANGUAGE PYTHON` (etc.). If you don't specify, it defaults to SQL. (A Python UDF example was promised for a later session.)
### 3. HANDS-ON #1 — `fn_days_left` (scalar UDF)
Requirement: given a date, return how many days are left in that date's year.
#### Building the logic piece by piece (the "why" behind each function)
The instructor built this interactively — here's the reasoning:
1. How many days have elapsed this year? → DAYOFYEAR(CURRENT_DATE()). On the day of the demo it returned 271 (271st day of the year).
1. Naive idea: 365 - DAYOFYEAR(...). But where does 365 come from? Hard-coding 365 breaks on leap years. We need the *actual* last day of the year computed from the date.
1. Find the last day of the year without hard-coding:
- DATE_FROM_PARTS(YEAR(d), 1, 1) → Jan 1 of that year (start of year).
- To reach the end of the year, add 11 months: DATEADD('month', 11, <Jan 1>) → lands on Dec 1.
- But we want the *last* day of December, not Dec 1. Use `LAST_DAY(...)` → gives Dec 31. LAST_DAY returns the last day of the month of whatever date you give it.
1. Difference between today and Dec 31: DATEDIFF('day', CURRENT_DATE(), <Dec 31>).
- A + 1 adjustment was discussed to make the count inclusive/match the intended definition.
- On the demo date the result was ~94 days left.
#### The function
CREATE OR REPLACE FUNCTION fn_days_left(p_date DATE)
RETURNS NUMBER
AS
$$
    DATEDIFF('day', p_date, LAST_DAY(DATEADD('month', 11, DATE_FROM_PARTS(YEAR(p_date), 1, 1))))
$$;
- Note how the hard-coded "today" in the exploratory query is replaced by the parameter `p_date` inside the body.
- Return type declared as RETURNS NUMBER.
- No `BEGIN`/`END`/`RETURN` — body is one expression. (This was the fix after the first failed attempt.)
#### Calling it
SELECT fn_days_left(CURRENT_DATE());        -- → 94
SELECT 'Days left: ' || fn_days_left(CURRENT_DATE()) || ' days';   -- make it a friendly message
⚠️ You call it with `SELECT`, never CALL. "You cannot use the CALL keyword for a function."
### 4. HANDS-ON #2 — `normalize_email` (scalar UDF, cleaning text)
Requirement: incoming emails sometimes arrive in UPPERCASE from the source; standardize them to trimmed lowercase.
CREATE OR REPLACE FUNCTION normalize_email(p_email STRING)
RETURNS STRING
AS
$$
    LOWER(TRIM(p_email))
$$;
- Body: trim the spaces, then lowercase. One expression — scalar UDF.
#### Using it against a real table (`T_CUSTOMER`)
T_CUSTOMER has a C_EMAIL_ADDRESS column. The demo first forced all emails to uppercase to simulate messy source data:
UPDATE T_CUSTOMER SET C_EMAIL_ADDRESS = UPPER(C_EMAIL_ADDRESS);

-- raw (uppercase)
SELECT C_CUSTOMER_SK, C_FIRST_NAME, C_EMAIL_ADDRESS FROM T_CUSTOMER;

-- cleaned via the UDF inside the SELECT
SELECT C_CUSTOMER_SK, C_FIRST_NAME, normalize_email(C_EMAIL_ADDRESS) AS clean_email
FROM T_CUSTOMER;
🧠 Takeaway: a scalar UDF slots straight into the column list of a SELECT and transforms each row's value. This is the classic "apply a business cleaning rule everywhere" use case.
### 5. HANDS-ON #3 — `get_transaction_risk` (business rules + validate with `IFF()`)
Requirement: classify a transaction's risk from its amount and country.
Business rules demonstrated:
- amount IS NULL → 'UNKNOWN'
- amount > 10000 → 'HIGH'
- amount > 1000 AND country not in an allowed/safe list → 'MEDIUM'
- otherwise → 'LOW'
CREATE OR REPLACE FUNCTION get_transaction_risk(p_amount NUMBER, p_country STRING)
RETURNS STRING
AS
$$
    CASE
        WHEN p_amount IS NULL           THEN 'UNKNOWN'
        WHEN p_amount > 10000           THEN 'HIGH'
        WHEN p_amount > 1000
             AND p_country NOT IN ('US','UK','IN')  THEN 'MEDIUM'
        ELSE 'LOW'
    END
$$;
*(The exact country list is illustrative — the point is the CASE encodes your business policy.)*
#### Validating the UDF with a temp table + `IFF()`
This is a neat testing pattern the instructor stressed. The idea: store rows *with an actual_risk you expect*, run the UDF to compute the risk, then compare.
-- temporary table: lives only for the session (introduced here for the first time)
CREATE OR REPLACE TEMPORARY TABLE transaction_risk_test (
    transaction_id NUMBER,
    amount         NUMBER,
    country        STRING,
    actual_risk    STRING          -- the expected answer we hand-wrote
);

INSERT INTO transaction_risk_test VALUES
    (1, NULL,  'US', 'UNKNOWN'),
    (2, 50000, 'XX', 'HIGH'),
    (3, 2000,  'XX', 'MEDIUM'),
    (4, 500,   'US', 'LOW');

-- compare computed vs expected
SELECT transaction_id,
       amount,
       country,
       actual_risk,
       get_transaction_risk(amount, country) AS computed_risk,
       IFF(get_transaction_risk(amount, country) = actual_risk, 'PASS', 'FAIL') AS result
FROM transaction_risk_test;
- `IFF(condition, value_if_true, value_if_false)` → compares two values; returns 'PASS' when the UDF output matches the expected actual_risk, else 'FAIL'.
- In the demo everything returned PASS, confirming the UDF logic matches expectations.
🧠 Why this matters: this is how you *unit-test* a UDF in plain SQL — expected column + IFF comparison. Also note TEMPORARY TABLE was introduced here: a table that exists only for your session and disappears when the session ends — perfect for throwaway test data.

A CASE WHEN transaction_rate = 1 THEN 'UNKNOWN' WHEN = 2 THEN 'HIGH' ... variant was also shown just to illustrate branching on a column's values — those are hard-coded demo values, not a real rule.
### 6. HANDS-ON #4 — VARIANT / JSON: `PARSE_JSON` on insert, `GET_PATH` UDF on read
#### 6a. What VARIANT is
- `VARIANT` is a data type that holds semi-structured data (JSON, etc.) inside a single column. Alongside NUMBER, VARCHAR, etc., VARIANT lets you stash a whole JSON document in one column.
#### 6b. Store JSON — you must wrap it in `PARSE_JSON`
Create a table with a VARIANT column (payload) and insert JSON:
CREATE OR REPLACE TABLE events_raw (
    id      NUMBER,
    payload VARIANT
);
- Gotcha hit live: a plain INSERT ... VALUES (1, '{...}') fails — you can't drop a raw string straight into a VARIANT. Snowflake complained about character vs variant.
- Fix: wrap the JSON string in `PARSE_JSON('...')`. PARSE_JSON both validates that the JSON is well-formed and converts the string into a true VARIANT value.
- Because INSERT ... VALUES can't call PARSE_JSON directly in all cases, use the `INSERT ... SELECT` form:
INSERT INTO events_raw
SELECT 1, PARSE_JSON('{"customer_id":101,"event_type":"login","amount":200,"customer_email":"A@X.COM"}');

INSERT INTO events_raw
SELECT 2, PARSE_JSON('{"customer_id":102,"event_type":"purchase","amount":5000,"customer_email":"B@Y.COM"}');

INSERT INTO events_raw
SELECT 3, PARSE_JSON('{"customer_id":103,"event_type":"refund","amount":1500,"customer_email":"C@Z.COM"}');

SELECT * FROM events_raw;   -- payload column shows the JSON
🧠 Memory hook: "PARSE_JSON on the way in." It's your validator + converter when writing JSON into a VARIANT column.
#### 6c. Read JSON — build a UDF around `GET_PATH`
- `GET_PATH(variant, 'key')` is a built-in that pulls a value out of a VARIANT by key/path. Missing key → NULL (seen live: asking for a phone key that didn't exist returned null).
- Wrap it in a UDF so reads are tidy:
CREATE OR REPLACE FUNCTION get_event_value(p_event_data VARIANT, p_field_path STRING)
RETURNS VARIANT
AS
$$
    GET_PATH(p_event_data, p_field_path)
$$;
- Two parameters: the VARIANT column, and the field path (a string).
- Flatten the JSON into columns by calling the UDF once per key:
SELECT
    get_event_value(payload, 'customer_id')     AS customer_id,
    get_event_value(payload, 'event_type')      AS event_type,
    get_event_value(payload, 'amount')          AS amount,
    get_event_value(payload, 'customer_email')  AS customer_email
FROM events_raw;
→ turns the JSON documents into a neat tabular result.
🔁 The pattern in one line: `PARSE_JSON` when inserting, `GET_PATH` (via a UDF) when selecting.

⚠️ Nested JSON: GET_PATH reaches straightforward keys. For nested arrays/objects you still need `LATERAL FLATTEN` (from Classes 4 & 6) — a UDF around GET_PATH does *not* replace flattening. This example is just about saving a JSON into a VARIANT column and reading top-level keys back.
A second quick example reinforced the same idea: a customer_info-style JSON (with keys like area/city) stored in a VARIANT temp table, then read back with the same get_event_value(col, 'key') approach.
### 7. UDTFs (User-Defined Table Functions) — previewed
Just as you've used built-in table functions (COPY_HISTORY, QUERY_HISTORY, TASK_HISTORY), you can create your own table functions — UDTFs — that return a table instead of a single value. These "seam with the procedures" (fit alongside the stored-proc work you've done). Deeper coverage deferred to a later session.
### 8. Previewed for NEXT class (NOT covered here — honest labeling)
The last few minutes flashed functions to be done next session:
- Masking a phone number (data-masking style function).
- `calculate_discount` — rules like: order_amount IS NULL → no discount; VIP customer → 20%; amount > 10,000 → 10%.
- Divide-by-zero guard — never divide by 0 in calculations; make sure the denominator isn't 0 (and handle it when it is).
- More built-in functions ("average functions") + the Python UDF example.
Also: a student asked how many sessions remain for Snowflake — Krishna said he'd confirm the next day (consistent with "course nearly done").
### 9. Cheat-sheet / quick recall

*End of Class 21 notes. Next: Class 21 hands-on walkthrough in your own account, then (next class) phone masking / calculate_discount / divide-by-zero + Python UDF.*

