# Class 28 — Iceberg Tables: DML + File Internals
## Snowflake — Class 28 Notes
### Iceberg Tables (completed): DML + inspecting the data & metadata files under the hood
Class length: ~67 min. Honest labeling: This class completes the iceberg table topic that Class 27 couldn't finish (AWS permission issues last time). This session the setup worked, and Krishna did the full thing: created an external volume + iceberg table, loaded data, performed DML (INSERT/UPDATE), and then — the genuinely interesting part — downloaded and inspected the actual data files (Parquet) and metadata files (JSON + Avro) from S3 to show how iceberg works internally. Hybrid and dynamic tables are previewed for next class. (Note: you already did this hands-on with me and went even further — this matches what you built.)
### 1. Recap: External Table vs Iceberg Table

🧠 The two formats to remember: in an iceberg table, DATA = Parquet files, METADATA = JSON + Avro files. Both live in your S3 bucket.
### 2. The setup (same as Class 27, but it worked this time)
The three ingredients for an iceberg table:
1. External Volume — like a storage integration; connects Snowflake to S3.
1. `BASE_LOCATION` — a folder name; Snowflake auto-creates it in S3 with data/ and metadata/ subfolders.
1. `CATALOG = 'SNOWFLAKE'` — Snowflake manages the catalog. (If using Spark/Glue instead, you'd specify that.)
-- 1. external volume
CREATE EXTERNAL VOLUME ext_volume
    STORAGE_LOCATIONS = ((
        NAME = 'iceberg'
        STORAGE_PROVIDER = 'S3'
        STORAGE_BASE_URL = 's3://your-bucket/'
        STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::...:role/...'
    ));

-- 2. the handshake: describe → get IAM user ARN + external ID → paste into AWS trust policy
DESC EXTERNAL VOLUME ext_volume;

-- 3. verify connectivity
SELECT SYSTEM$VERIFY_EXTERNAL_VOLUME('ext_volume');   -- look for "success":true

-- 4. create the iceberg table
CREATE ICEBERG TABLE t_ib_cust_info (...)
    CATALOG = 'SNOWFLAKE'
    EXTERNAL_VOLUME = 'ext_volume'
    BASE_LOCATION = 'cust_info';
#### A handy trick: auto-format the DESC output
DESC EXTERNAL VOLUME returns messy nested text. To get clean JSON (so you can copy the external ID / IAM user ARN easily):
-- run DESC, grab its query_id, then:
SELECT PARSE_JSON("property_value")
FROM TABLE(RESULT_SCAN('<query_id>'))
WHERE "property" = 'STORAGE_LOCATION_1';
- `RESULT_SCAN('<query_id>')` re-reads the output of a previous query as a table.
- `PARSE_JSON(...)` turns the value column into properly-formatted JSON.
🧠 This is a nice reusable trick: RESULT_SCAN + PARSE_JSON to tidy up any messy DESC output.
### 3. What appears in S3 (the folder structure)
After creating the table (but before any data):
your-bucket/
  cust_info/              ← the BASE_LOCATION folder (auto-created)
    metadata/
      00000-....metadata.json    ← version 0 (table created, empty)
After loading data:
    metadata/
      00000-....metadata.json    ← v0 (create)
      00001-....metadata.json    ← v1 (after insert)
      ....avro                   ← manifest + snapshot files
    data/
      ....parquet                ← the actual rows, in Parquet format
🧠 Key fact: with no data, you only have a metadata/ folder (the table structure exists but there are no rows). The data/ folder appears only after you insert data. This was shown live.
### 4. DML works on iceberg tables ⭐
Unlike external tables (read-only), iceberg tables support full DML:
-- INSERT (COPY INTO is also an insert)
COPY INTO t_ib_cust_info FROM (SELECT ... FROM @stage (file_format=>csv_format));
INSERT INTO t_ib_cust_info VALUES (...);

-- UPDATE
UPDATE t_ib_cust_info SET company = 'Paytm' WHERE company = 'TCS';

-- DELETE also works
DELETE FROM t_ib_cust_info WHERE id = 3;
What happens in S3 when you do DML (the "aha"):
- Every DML operation creates NEW files in S3 — it does not modify existing files in place.
- An UPDATE → a new Parquet data file appears in data/ (with the updated rows) + a new metadata.json + new Avro snapshot in metadata/.
- The old files stay → this is how iceberg keeps version history / time-travel.
🧠 The core insight: iceberg is immutable-file-based. It never edits a file; each change writes new files and records a new metadata version. That's why you see metadata.json files pile up (00000, 00001, 00002...) — each is a version of the table. (You saw this live: after INSERT + UPDATE + DELETE you had 4 metadata.json files.)
### 5. Peeking inside the files (the deep-dive)
Krishna downloaded the actual files from S3 and loaded them back into Snowflake tables to show their contents. This is the most illuminating part:
#### Metadata JSON files — the table's "blueprint"
Contains table structure info: the location, how many columns (e.g. 14 columns), each column's name + data type + sequence number. This is the schema/catalog info.
-- read a metadata JSON file to inspect it
SELECT $1 FROM @json_stage/metadata_file.json (file_format=>json_format);
#### Avro files — manifests & snapshots
Two kinds of Avro files:
- Snapshot files (snap-....avro) → a point-in-time view of the table.
- Manifest files (...-m0.avro) → list which data files belong to the table. Contains columns like: status, snapshot_id, sequence_number, data_file, added_files_count, deleted_files_count, added_rows_count, existing_rows_count, partitions, etc. (~15 columns of bookkeeping).
#### Data Parquet files — the actual rows
The data/ folder holds Parquet files with your real data. Each DML creates a new Parquet file.
🧠 The three file types, summarized:
- Parquet (in data/) = your actual rows.
- metadata.json = schema/structure (columns, types, location) — one per version.
- Avro = manifests (which data files exist) + snapshots (point-in-time views).
Together they implement the open Apache Iceberg format, so any engine (Snowflake, Spark, Trino) can read the same table.
### 6. Why iceberg tables matter (the use case)
- Data + metadata in open formats in *your* cloud storage, not locked inside Snowflake.
- Interoperability: multiple engines (Snowflake, Spark, Glue, Trino) can read/write the same table.
- Full DML (unlike external tables) + built-in versioning/time-travel via the metadata snapshots.
- Krishna: *"mostly you will use iceberg tables"* in modern real-world data platforms.
### 7. Previewed for next class
- Hybrid tables (OLTP-style, for transactional workloads).
- Dynamic tables (auto-refreshing, declarative pipelines).
- Krishna called these "the two important tables" to cover next.
### Cheat-sheet / quick recall

*End of Class 28 notes. Topic = iceberg tables completed (DML + inspecting Parquet/JSON/Avro files under the hood). Next: hybrid tables + dynamic tables.*

