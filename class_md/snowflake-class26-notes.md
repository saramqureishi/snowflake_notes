# Class 26 — Transient Tables & External Tables
## Snowflake — Class 26 Notes
### Transient Tables (deep-dive) + External Tables (end-to-end)
Class length: ~54 min. Honest labeling: This class picks up from Class 25's table-types overview and does a full deep-dive on transient tables (when to use, storage cost comparison, retention limits) and then the entire external table workflow end-to-end (create S3 integration → stage → external table → query → metadata → refresh → auto_refresh). Iceberg tables are previewed/started but deferred to the next session (Krishna had to leave early for office work). The trainer's SQL notes through Class 27 were cross-referenced.
### PART A — Transient Tables (deep-dive)
#### Recap from Class 25
- Permanent (default): up to 90 days Time Travel + 7 days Fail-safe.
- Temporary: session-only, auto-dropped at logout, no TT/FS.
- Transient: sits *between* the two — max 1 day TT, no Fail-safe.
#### New in Class 26: the details
Max retention = 1 day (hard limit).
Krishna tried ALTER TABLE t_transient SET DATA_RETENTION_TIME_IN_DAYS = 2 → error: *"invalid value for data_retention_time_in_days"*. You cannot set a transient table's retention above 1. This was proven live.
When to use transient tables (2 scenarios):
1. Truncate-and-load staging tables. Every day you receive files, truncate the staging table, and reload. If something goes wrong, your upstream (AWS team) can resend the file — you don't *need* Snowflake to keep old snapshots beyond 1 day. So transient saves you money.
1. Data you can easily re-obtain. If the source system can always resend the data, you don't need permanent-table-level protection. Use transient → lower storage cost.
#### Storage cost comparison ⭐ (exam point)
The class walked through TABLE_STORAGE_METRICS to show three cost components:

🧠 The cost story in one line: *Permanent = active + time_travel + fail_safe (most expensive). Transient = active + time_travel_1day (cheaper). Temporary = active only, session-scoped (cheapest, but gone at logout).*
You can see these via:
SELECT * FROM information_schema.table_storage_metrics;
Check transient table parameters:
SHOW PARAMETERS LIKE 'DATA_RETENTION%' IN TABLE t_transient;
### PART B — External Tables (end-to-end) ⭐⭐
#### What is an external table?
- The data stays in S3 (or Azure/GCP) — it is NOT copied into Snowflake.
- Only the metadata (what files exist, their structure) lives in Snowflake.
- You query the file as if it were a table — but it's read-only (no INSERT/UPDATE/DELETE).
🧠 Mental model: external table = "a window into S3." Data lives outside, you look through the window. You can look (SELECT), but you can't reach through and change it (no DML).
#### Why use external tables?
1. No storage cost in Snowflake — you're not storing data, just reading from S3.
1. Multiple teams can access the same data — Spark, Snowflake, other systems all read from the same S3 file.
1. Good for rarely-changing reference data — data that changes maybe once every 6 months or a year.
#### The full setup (step by step, same pattern as external stages from Class 8)
AWS side:
1. Create an S3 bucket + folder + upload a Parquet file.
1. Create an IAM Role with AmazonS3FullAccess.
1. Copy the role's ARN.
Snowflake side:
1. Storage Integration (the handshake):
CREATE STORAGE INTEGRATION aws_integration
    TYPE = EXTERNAL_STAGE
    STORAGE_PROVIDER = 's3'
    STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::...:role/...'
    ENABLED = TRUE
    STORAGE_ALLOWED_LOCATIONS = ('s3://bucket/folder/');
1. Describe the integration → get Snowflake's STORAGE_AWS_IAM_USER_ARN + STORAGE_AWS_EXTERNAL_ID → paste into the IAM Role's Trust Policy (same handshake as Class 8).
1. External Stage:
CREATE STAGE aws_parquet_stage
    URL = 's3://bucket/stg_parquet_files/'
    STORAGE_INTEGRATION = AWS_INTEGRATION
    DIRECTORY = (ENABLE = true);
1. File Format:
CREATE FILE FORMAT parquet_format TYPE = PARQUET;
#### Creating the external table — two approaches
Approach 1: Simple (auto-JSON column)
CREATE EXTERNAL TABLE t_ext_cust_info_new
    LOCATION = @aws_parquet_stage
    FILE_FORMAT = parquet_format;
- This creates a table with a single column called `VALUE` containing JSON (Snowflake auto-converts Parquet → JSON).
- Read keys with: SELECT value:birthdate, value:salary FROM t_ext_cust_info_new;
Approach 2: Define columns explicitly (recommended)
Use INFER_SCHEMA to get the column definitions, then create with typed columns:
CREATE EXTERNAL TABLE t_ext_cust_info (
    registration_dttm TIMESTAMP_NTZ AS (VALUE:registration_dttm::TIMESTAMP_NTZ),
    id                NUMBER        AS (VALUE:id::NUMBER),
    first_name        TEXT          AS (VALUE:first_name::TEXT),
    last_name         TEXT          AS (VALUE:last_name::TEXT),
    email             TEXT          AS (VALUE:email::TEXT),
    -- ... etc.
)
LOCATION = @aws_parquet_stage
FILE_FORMAT = parquet_format;
- Each column definition = col_name TYPE AS (VALUE:key::TYPE) — you're telling Snowflake "for this column, pull this key from the JSON VALUE column and cast it."
- The `VALUE` column still exists (it holds the raw JSON), but you can exclude it: SELECT * EXCLUDE VALUE FROM t_ext_cust_info;
🧠 Column definition pattern: column_name DATATYPE AS (VALUE:key_name::DATATYPE). VALUE is the auto-generated JSON column; :key_name extracts a key; ::TYPE casts it.
#### Auto-generating the column definitions with INFER_SCHEMA
Instead of typing each column by hand:
SELECT CONCAT(column_name, ' ', type, ' AS (', REPLACE(expression, '$1', 'VALUE'), '),')
FROM TABLE(INFER_SCHEMA(
    LOCATION => '@aws_parquet_stage',
    FILE_FORMAT => 'parquet_format',
    FILES => 'Users_Info.parquet'
));
This outputs copy-paste-ready column definitions — same INFER_SCHEMA trick from Classes 4–5, adapted for external tables by replacing $1 with VALUE.
#### DML is NOT allowed
DELETE FROM t_ext_cust_info;
-- ERROR: "the target should be a table" — external table is read-only
You cannot INSERT, UPDATE, or DELETE on an external table. It's a read-only window into S3.
#### Metadata functions
Two table functions for external table metadata:
-- what files does the external table see?
SELECT * FROM TABLE(information_schema.external_table_files(
    TABLE_NAME => 't_ext_cust_info'));

-- file registration history (what files have been added/removed)
SELECT * FROM TABLE(information_schema.external_table_file_registration_history(
    TABLE_NAME => 't_ext_cust_info'));
#### Metadata refresh — the BIG gotcha ⭐
The problem demonstrated live:
1. Krishna deleted the Parquet file from S3.
1. Queried the external table → data still appeared! 😱
1. Why? The metadata hadn't been refreshed — Snowflake still *thought* the file existed.
The fix — manual refresh:
ALTER EXTERNAL TABLE t_ext_cust_info REFRESH;
-- "1 file unregistered"
After refresh → query returns no data (correct).
🧠 Critical rule: external table metadata does NOT auto-refresh by default. If you add or remove files in S3, Snowflake won't know until you either:
1. Manually refresh: ALTER EXTERNAL TABLE t REFRESH;
2. Enable auto-refresh: add AUTO_REFRESH = TRUE when creating the table (requires an event notification setup, similar to Snowpipe's SQS channel).
Auto-refresh:
CREATE EXTERNAL TABLE t_ext_auto (...)
    LOCATION = @stage
    FILE_FORMAT = fmt
    AUTO_REFRESH = TRUE;     -- metadata updates automatically when files change in S3
With AUTO_REFRESH = TRUE, when files are added/removed in S3, the metadata updates automatically (via an event notification channel — same concept as Snowpipe). Without it, you must run ALTER ... REFRESH manually.
### PART C — Iceberg Tables (previewed, NOT covered)
Krishna started mentioning iceberg tables (is_iceberg = 'YES') and said:
- Data lives in S3 (like external tables), but metadata is managed by Snowflake.
- You use an External Volume instead of a storage integration.
- "Mostly you will use iceberg tables" (real-world relevance).
- Full coverage is deferred to the next session (he had to leave for office work).
### Cheat-sheet / quick recall

*End of Class 26 notes. Topics = transient tables (deep-dive) + external tables (end-to-end). Next: iceberg tables (deferred from this class).*

