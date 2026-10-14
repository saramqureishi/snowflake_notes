# Class 27 — Iceberg Tables
## Snowflake — Class 27 Notes
### Iceberg Tables (concept + setup attempt)
Class length: ~64 min. Honest labeling: This class is meant to cover Iceberg Tables — the table type where both data AND metadata live outside Snowflake (in S3). However, a large chunk of the class was spent troubleshooting AWS permission issues on a newly created AWS account (IAM role trust policies, S3 write permissions, CloudTrail event history debugging). Krishna tried multiple AWS accounts to get the iceberg table creation working. The conceptual teaching is solid; the hands-on hit real-world AWS friction. The setup eventually worked on a different (older) account, but the full iceberg-table demonstration (insert data, query it, see folders in S3) was not completed within this session.

Key teaching: the *concept* of iceberg tables (where data+metadata live, how it differs from external tables, the External Volume object) was clearly explained in the first ~20 min. The rest was AWS setup/debugging.
### 1. Recap: External Table vs Iceberg Table

🧠 The key difference in one line: external table = data outside, metadata inside Snowflake. Iceberg table = BOTH data and metadata outside (in S3). And because the metadata format is open (Apache Iceberg), other tools (Spark, Trino, etc.) can also read/write the same table — it's not locked to Snowflake.
### 2. What is an Iceberg Table?
- Apache Iceberg is an open table format — a standard way to organize data files + metadata files in cloud storage.
- A Snowflake iceberg table stores its data AND metadata in your S3 bucket, using the Iceberg format.
- Unlike external tables (read-only), iceberg tables support full DML (INSERT, UPDATE, DELETE).
- Multiple engines (Snowflake, Spark, Trino, etc.) can all access the same iceberg table — it's interoperable.
When to use:
- When you want Snowflake to manage a table but keep the data in *your* cloud storage (not Snowflake's internal storage).
- When multiple tools need to read/write the same data (cross-engine interoperability).
- In real-time projects, Krishna said *"mostly you will use iceberg tables."*
### 3. Creating an Iceberg Table — the 3 required parameters
CREATE ICEBERG TABLE t_ib_cust_info (
    id        NUMBER(10,0),
    firstname VARCHAR,
    lastname  VARCHAR,
    email     VARCHAR
)
CATALOG = 'SNOWFLAKE'                -- always 'SNOWFLAKE' when using Snowflake as catalog
EXTERNAL_VOLUME = ext_volume         -- like a storage integration (connects to S3)
BASE_LOCATION = 'cust_info';        -- a folder name: S3 will auto-create this folder
                                     -- data + metadata subfolders go inside it
The three parameters:
1. `CATALOG = 'SNOWFLAKE'` — tells Snowflake it manages the catalog. (Default when working in Snowflake.)
1. `EXTERNAL_VOLUME = ext_volume` — like a storage integration, establishes the connection to S3. (New object type — see §4.)
1. `BASE_LOCATION = 'cust_info'` — a folder name. Snowflake auto-creates this folder in your S3 bucket, and inside it creates two subfolders: one for data files and one for metadata files.
🧠 `BASE_LOCATION` is the key concept: whatever name you give here, S3 gets a folder with that name, and Snowflake stores the actual Parquet data files + Iceberg metadata files inside it. You can see them in the S3 console.
Note on NUMBER columns: iceberg tables require precision and scale for NUMBER columns — e.g. NUMBER(10,0), not just NUMBER. Without it, creation fails with an error.
### 4. External Volume (the new connection object)
An External Volume is like a storage integration, but specifically for iceberg tables. It establishes the connection between Snowflake and your S3 bucket so Snowflake can write data + metadata there.
-- check existing external volumes
SHOW EXTERNAL VOLUMES;

-- create one
CREATE EXTERNAL VOLUME ext_volume
    STORAGE_LOCATIONS = (
        (
            NAME = 'iceberg'
            STORAGE_PROVIDER = 'S3'
            STORAGE_BASE_URL = 's3://your-bucket-name/'
            STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::...:role/your-role-name'
        )
    );

-- describe it to get Snowflake's identity (same handshake as storage integration)
DESC EXTERNAL VOLUME ext_volume;
The output of DESC EXTERNAL VOLUME gives you:
- `STORAGE_AWS_IAM_USER_ARN` — Snowflake's user ARN (paste into IAM trust policy)
- `STORAGE_AWS_EXTERNAL_ID` — Snowflake's external ID (paste into IAM trust policy)
🧠 Same handshake pattern: create the volume → DESC it → get Snowflake's identity → paste into the AWS IAM role's Trust Policy. Identical flow to storage integrations (Class 8), just a different Snowflake object.
#### Verify the external volume can reach S3
SELECT SYSTEM$VERIFY_EXTERNAL_VOLUME('ext_volume');
This checks whether Snowflake can read/write/list/delete in the S3 location. Returns a JSON with PASSED or FAILED for each operation.
### 5. AWS IAM role for Iceberg (differs from external tables)
For external tables, AmazonS3FullAccess worked fine (read-only). For iceberg tables, Snowflake needs write permission too (it stores data in S3). The class demonstrated:
- An inline policy granting specific S3 permissions on the bucket (more restrictive than full access).
- The same Trust Policy handshake: edit the role's Trust Relationships → paste Snowflake's IAM_USER_ARN and EXTERNAL_ID.
🧠 Why write access matters: with external tables, Snowflake only *reads* from S3 (data is already there). With iceberg tables, Snowflake *writes* data and metadata to S3 — so the IAM role must have write/put/delete permissions, not just read.
### 6. Identifying Iceberg Tables in metadata
SELECT * FROM information_schema.tables WHERE is_iceberg = 'YES';
### 7. Troubleshooting seen in class (real-world lessons)
- "External volume does not have privilege to write" — the IAM role didn't have S3 write permissions. Fix: add write/put permissions to the role's policy.
- "Error assuming AWS_ROLE" — the trust policy wasn't correctly configured (wrong external ID or IAM user ARN). Fix: re-describe the external volume, copy the exact values, paste into the trust policy.
- CloudTrail Event History — Krishna used AWS CloudTrail to debug permission issues (check if AssumeRole events were succeeding or failing).
- New AWS accounts may have different default permission structures — Krishna's new account had issues his older account didn't. He eventually switched to the older account to complete the demo.
🧠 Real-world takeaway: iceberg table setup is mostly an AWS permissions exercise. In production, the AWS admin team handles bucket/role/policy creation — as the Snowflake engineer you mainly need the external volume + the three parameters. But understanding the permission flow helps you debug when things don't connect.
### 8. What was NOT completed in this class (honest labeling)
- Inserting data into the iceberg table and seeing the data + metadata folders appear in S3.
- Querying the iceberg table.
- DML operations (UPDATE/DELETE) on an iceberg table to prove it's not read-only like external tables.
- Comparing iceberg vs permanent table behaviour.
These are likely covered in a follow-up session.
### Cheat-sheet / quick recall

*End of Class 27 notes. Topic = iceberg tables (concept + External Volume + partial setup). Full iceberg demo (insert/query/DML) not completed due to AWS permission issues — likely continues next session.*

