# Class 43 — Secure Data Sharing: Shares, Provider/Consumer & Reader Accounts

**Snowflake — Class 43 Notes**
*Sara — SnowPro Core preparation*

> ⭐⭐ **This one is exam-relevant and important.** Data Sharing is a core SnowPro Core topic (part of the "data sharing / collaboration" domain) and the trainer taught it properly with a full hands-on, not just a preview. Learn it.
>
> **Honest labelling:**
> - Sections **1–6** are the exam content (shares, inbound/outbound, provider/consumer, secure direct share, reader accounts, read-only shared databases).
> - The trial account expired at the start, so he **created a fresh trial** and rebuilt DEV_DB / DEV_WAREHOUSE live. (Reminder from the handover: if your own trial expires, just make a new free trial — never add billing.)
> - He did **not** get to clustering/scaling this class (promised from Class 42); he said he'll **continue clustering/performance next session**. So that's still owed.
>
> **Things he said that matter to you (flagged as you asked):**
> - 🎓 **Free Snowflake badges:** he shared a URL to Snowflake's free learning/badge tracks ("Data Warehousing Workshop" etc.) — complete the course, get a badge, post it on LinkedIn. **Ask him to re-share that URL** and do one or two; they're free and CV-friendly.
> - 📚 **Interview questions + documents:** a student again asked him to **upload the interview questions and documents to the Drive**. He said **"by 4:30"** he'll do it. This is likely the same promised folder — **chase the Drive link.**
> - ⚠️ The **cost-of-sharing question** (who pays when a consumer queries shared data?) he deferred as "admin, I'm not sure, I'll get back to you." See §7 for the correct exam answer so you're not left with a gap.

---

## 1. What a Share is ⭐

- A **share** is a named Snowflake object that lets you give **read-only** access to selected database objects (database → schema → tables/views) to **another account** — without copying any data.
- Two directions of sharing:
  - **Snowflake account → Snowflake account** (both are Snowflake customers).
  - **Snowflake account → non-Snowflake consumer** (via a **reader account** — see §5).
- Key idea he stressed: **provider is a Snowflake account, consumer can be a Snowflake account *or* a non-Snowflake user.** No data movement — the consumer queries the provider's live data.

## 2. Inbound vs outbound shares ⭐

```sql
SHOW SHARES;
```
- **INBOUND** = shares **given to you** by someone else (you're the consumer).
- **OUTBOUND** = shares **you created** to give to others (you're the provider).
- ⭐ Every brand-new Snowflake account starts with **two inbound shares** from Snowflake itself:
  - **SNOWFLAKE** (the `SNOWFLAKE` db — ACCOUNT_USAGE / ORGANIZATION_USAGE views)
  - **SNOWFLAKE_SAMPLE_DATA** (the TPC sample datasets, e.g. `CUSTOMER` ~150k rows)
- That's *why* you get those databases for free the moment you create an account — they arrive **through inbound shares**, not because you created them.

## 3. Your Snowflake account = ORG name + ACCOUNT name ⭐

Verify who you are / where you are:
```sql
SELECT CURRENT_ACCOUNT();            -- account locator / name
SELECT CURRENT_ORGANIZATION_NAME();  -- organization name
SELECT CURRENT_ACCOUNT_NAME();       -- account name
```
- ⭐ A **full Snowflake account identifier = `ORG_NAME.ACCOUNT_NAME`** (e.g. his TCS / "enterprise data" example). You need the **consumer's** account identifier to add them to a share.
- Yours (handover): org **YVVTNMA**, account in region **AWS_EU_WEST_2** → account `YVVTNMA-XS79799`.

## 4. Creating & populating a share (provider side) ⭐⭐

This is the hands-on flow he ran. Do it as a batch (Run All), check at the end:

**Batch A — create the share and grant objects into it**
```sql
-- 1. create an (empty) outbound share
CREATE SHARE test_share;

-- 2. grant the object hierarchy to the share (DB -> schema -> table)
GRANT USAGE ON DATABASE dev_db TO SHARE test_share;
GRANT USAGE ON SCHEMA dev_db.dev_schema TO SHARE test_share;
GRANT SELECT ON TABLE dev_db.dev_schema.<your_table> TO SHARE test_share;

-- 3. check what the share now contains
SHOW GRANTS TO SHARE test_share;   -- should list DB + schema + table (3 objects)
```
- A fresh share is **outbound**, `database = NULL`, `to = NULL` until you grant objects and add a consumer.
- You grant to a **SHARE** almost exactly like you grant to a **role**: `GRANT USAGE ON DATABASE … / USAGE ON SCHEMA … / SELECT ON TABLE …` — just the target is `TO SHARE <name>` instead of `TO ROLE <name>`. ⭐ (Good exam contrast: roles get privileges for *users inside your account*; shares get privileges for *other accounts*.)
- Verify a share two ways: `DESCRIBE SHARE test_share;` **or** `SHOW GRANTS TO SHARE test_share;`.

**Batch B — add the consumer Snowflake account to the share**
```sql
-- add another Snowflake account as a consumer of the share
ALTER SHARE test_share ADD ACCOUNTS = <consumer_org>.<consumer_account>;

-- check: the share's "to" column is now populated
SHOW SHARES;        -- test_share: type=OUTBOUND, database set, to = consumer account
```

**Consumer side (the other Snowflake account):** the share appears under **Data Sharing → … → Get Data** (or `CREATE DATABASE <name> FROM SHARE <provider>.<share>;`). The consumer mounts it as a **database**.

## 5. Reader accounts (= "managed accounts") — for NON-Snowflake consumers ⭐⭐

If the consumer is **not** a Snowflake customer, you can't `ALTER SHARE … ADD ACCOUNTS` their account (they don't have one). Instead the **provider creates a reader account**:

- Snowsight: **Data Sharing → … → Reader accounts → Create**. Give it a name (e.g. `reader_test`), an **admin username + password**, and a comment.
- A reader account is **also called a MANAGED ACCOUNT**:
  ```sql
  SHOW MANAGED ACCOUNTS;   -- lists reader accounts; empty until you make one
  ```
- Snowflake spins up a **separate account URL** (takes ~5 minutes to activate). The non-Snowflake user logs into *that* URL with the username/password you set — **they never become a Snowflake customer.**
- Add the reader account to a share the same way, using its locator:
  ```sql
  ALTER SHARE test_share ADD ACCOUNTS = <reader_account_locator>;
  ```
- ⭐⭐ **Key exam points on reader accounts:**
  - They let a **non-Snowflake consumer** read shared data.
  - The **provider owns and PAYS for** the reader account's storage **and all its compute** (the reader has no billing relationship with Snowflake). This is the cost gotcha in §7.
  - His business example: a sales prospect gets a temporary reader account to trial a data product before deciding to become a Snowflake customer.

## 6. Shared databases are READ-ONLY ⭐⭐

Once a consumer mounts a share as a database and queries it:
```sql
USE ROLE ACCOUNTADMIN;
USE WAREHOUSE dev_warehouse;
USE DATABASE dev_db;      -- (consumer sees it as a shared DB)
USE SCHEMA dev_schema;
SELECT * FROM <shared_table>;              -- ✅ works
DELETE FROM <shared_table> WHERE ...;      -- ❌ fails
```
- ⭐⭐ A **shared (inbound) database is strictly read-only** — you get **SELECT only**, **no DML** (no INSERT/UPDATE/DELETE), and you **cannot see its DDL/definition** ("operation not supported on shared database"). He proved it by trying to `DELETE` from both his shared table and `SNOWFLAKE_SAMPLE_DATA.…CUSTOMER` — both blocked with "insufficient privileges".
- Normal (owned) databases **do** let you see the definition and run DML.
- So there are **two kinds of database**: **normal/owned** (full access) vs **shared/inbound** (read-only, no DDL visibility).

## 7. The "who pays?" question — the correct exam answer ⭐ (he deferred this)

A student asked: if a consumer queries a lot of shared data, who is charged and how do you optimise it? He deferred it as "admin". The exam-correct answer:

- **Compute is paid by whoever runs the query, using *their own* virtual warehouse.** In a normal share between two Snowflake accounts, the **consumer runs the query on the consumer's warehouse and pays for that compute**; the provider pays only for storing the data once.
- **Exception = reader accounts:** the reader has no billing relationship, so the **provider pays for all compute and storage the reader uses.** (That's the cost risk he was being asked about.) Mitigate it with a **resource monitor** on the reader account's warehouse(s) — which is exactly the upcoming "resource monitors" topic from the Class 42 list.
- **No storage duplication:** sharing never copies data, so there's no extra storage cost for the shared data itself — the consumer reads the provider's single copy.

## 8. Previewed / still owed

- **Clustering + performance** (with vs without clustering, real numbers) — promised in Class 42, **still not done**, he said he'll continue next session.
- Still outstanding from the running list: **SOS, QAS, resource monitors, DML vs micro-partitions, horizontal/vertical scaling.**
- 🎓 Free **Snowflake badges** URL + 📚 the **interview-questions / certification Drive folder** ("by 4:30").

## 9. Cheat-sheet / quick recall

- **Share** = named object giving **read-only, no-copy** access to DB/schema/table across accounts. `SHOW SHARES;` ⭐
- **INBOUND** = given *to* you; **OUTBOUND** = created *by* you. Every account starts with 2 inbound shares: **SNOWFLAKE** + **SNOWFLAKE_SAMPLE_DATA**. ⭐
- Account id = **ORG_NAME.ACCOUNT_NAME**. Check with `CURRENT_ACCOUNT()` / `CURRENT_ORGANIZATION_NAME()` / `CURRENT_ACCOUNT_NAME()`.
- Provider: `CREATE SHARE s;` → `GRANT USAGE ON DATABASE/SCHEMA`, `GRANT SELECT ON TABLE … TO SHARE s;` → `ALTER SHARE s ADD ACCOUNTS=<org.acct>;`. Verify: `DESCRIBE SHARE s;` or `SHOW GRANTS TO SHARE s;`. ⭐⭐
- Consumer: mounts the share as a **database** (Get Data / `CREATE DATABASE … FROM SHARE`).
- **Reader account = managed account** → for **non-Snowflake** consumers; `SHOW MANAGED ACCOUNTS;`. **Provider pays its compute + storage.** ⭐⭐
- **Shared DB = read-only**: SELECT only, **no DML, no DDL/definition visible.** ⭐⭐
- **Who pays:** normal share → **consumer's warehouse pays the compute**; reader account → **provider pays everything**; data is never duplicated. ⭐
- 📚 **Action:** get the trainer's **certification/interview Drive folder** (promised "by 4:30") and the **free-badges URL**.

*End of Class 43 notes. A full, exam-relevant Data Sharing class: shares and inbound/outbound, provider/consumer, creating & granting a secure direct share, reader (managed) accounts for non-Snowflake consumers, and the read-only nature of shared databases. Clustering/performance was pushed to next session.*
