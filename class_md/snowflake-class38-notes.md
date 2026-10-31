# Class 38 — dbt Tests Deep-Dive (the 4 generic tests + custom tests + the validation SQL)

**Snowflake — Class 38 Notes**
*Sara — SnowPro Core preparation*

> 🟡 **Honest labeling.** A full **dbt tests** class (continues Class 37). It's a dbt topic, BUT it has a **genuinely exam/interview-relevant core:** the four generic tests map 1:1 to **SQL constraints**, and the trainer **explicitly flagged** the underlying validation queries as askable — *"there may be a chance they ask you to write a query to validate a foreign-key or check constraint."* So the **constraint-validation SQL patterns** here are worth knowing for the exam, even though dbt itself isn't tested.
>
> **This is the leftover hands-on we parked** — the class covers exactly it (`not_null`/`unique`/`accepted_values`/`relationships` + custom tests). So you can treat these notes as "the hands-on, explained."
>
> **Event note (you asked me to flag these):** the trainer attended a Snowflake **event today (full day, 8:30–5:30)** on **AI features** — *registration is closed* — and said he'll prepare his own docs + take a session on it later.

---

## 0. Context

dbt **tests** = automated data-quality checks defined in YAML, attached to a model's column. Class 37 introduced `not_null`/`unique`; Class 38 completes the set (`accepted_values`, `relationships`) + **custom business tests**, and shows the **SQL dbt generates** for each.

---

## 1. ⭐ The 4 generic dbt tests = SQL constraints (memorize this mapping)

| dbt test | SQL constraint | What it checks | Fails when… |
|---|---|---|---|
| **`not_null`** | NOT NULL | no NULLs in column | any NULL exists |
| **`unique`** | UNIQUE | no duplicate values | any value repeats |
| **`accepted_values`** | CHECK | value ∈ an allowed list | a value outside the list exists |
| **`relationships`** | FOREIGN KEY | value exists in a parent model/column | a child value has no matching parent |

> **`not_null` + `unique` together = PRIMARY KEY.** `accepted_values` = CHECK. `relationships` = FK. (Top interview/exam one-liner.)

### How they're declared (YAML)
```yaml
version: 2
models:
  - name: t_customer_info
    columns:
      - name: customer_id
        tests:
          - not_null
          - unique

  - name: t_payment
    columns:
      - name: payment_method
        tests:
          - accepted_values:
              values: ['credit card','debit card','bank transfer','coupon']

  - name: t_orders
    columns:
      - name: customer_id
        tests:
          - relationships:
              to: ref('t_customers')      # parent model
              field: customer_id          # parent column
```

### Run tests
```
dbt test --select <model>
```
- Pass → no bad rows. Fail → dbt reports which test failed and how many bad rows.

---

## 2. ⭐⭐ The validation SQL dbt generates (trainer flagged: "they will ask… write a query to validate a FK / check constraint" — interview; also overlaps the exam's constraint-enforcement topic)

The trainer stressed: **know the query behind each test** — *"they may ask you to write a query to validate a FK or check constraint."* The pattern for all of them: **a test passes if its query returns ZERO rows** (it selects the *offending* rows).

**`not_null`** — find NULLs:
```sql
select * from <model> where customer_id is null;   -- rows returned = failures
```

**`unique`** — find duplicates:
```sql
select customer_id, count(*)
from <model>
group by customer_id
having count(*) > 1;                                -- rows returned = failures
```

**`accepted_values`** — find values outside the allowed list:
```sql
select payment_method
from <model>
where payment_method not in ('credit card','debit card','bank transfer','coupon');
```

**`relationships`** (FK) — find child rows with no parent, via **LEFT JOIN + parent IS NULL**:
```sql
select c.customer_id
from orders c
left join customers p on c.customer_id = p.customer_id
where p.customer_id is null;                         -- orphan children = failures
```
> ⭐ **These four query patterns are the exam-relevant takeaway** — especially the **LEFT JOIN … WHERE parent IS NULL** for foreign-key validation. Know how to hand-write them.

---

## 3. Custom (business-rule) tests ⭐

Beyond the 4 generics, you can write **custom tests** as SQL that returns offending rows. Examples demoed:
- **`paid_amount > allowed_amount`** → invalid (you can't pay more than allowed) → test returns those rows → fails.
- **inpatient = TRUE but admission_date IS NULL** → invalid (an admitted patient must have an admission date) → fails.
- These are defined as singular/custom test SQL and attached like the generics.
- 💬 Interview: *"dbt ships four generic tests mapping to NOT NULL / UNIQUE / CHECK / FK, and you can add custom SQL tests for business rules — any test is just a query that must return zero rows to pass."*

---

## 4. Important workflow point the trainer stressed

- **When a test fails, you fix the SOURCE DATA, not via dbt.** dbt is for **transformation**, not for editing/correcting records. Correct the bad data in the **source table in Snowflake** (or upstream), then re-run. *"It's not advisable to edit data from dbt."*
- Demo loop: insert bad data (NULL id / duplicate / `cash` payment / orphan order) → `dbt test` **fails** → fix the source row in Snowflake → `dbt test` **passes**. That fail→fix→pass loop is the whole point of tests.
- Reminder: **seeds** feed staging, so to fix seed-sourced data you edit the CSV seed and re-run **`dbt seed --select <seed>`**, then the model.

---

## 5. Previewed / housekeeping

- Changes committed to both the dev branch and `main`.
- Trainer at a Snowflake **AI-features event** today (registration closed) → will share a session later.

---

## 6. Cheat-sheet / quick recall

- **4 generic dbt tests → constraints:** `not_null`=NOT NULL, `unique`=UNIQUE, `accepted_values`=CHECK, `relationships`=FK. **not_null+unique = PK.** ⭐
- **A test passes iff its query returns 0 rows** (the query selects the *bad* rows).
- **Know the validation SQL** (trainer flagged as askable — interview; constraint enforcement itself is exam material): NULL check (`WHERE col IS NULL`), dup check (`GROUP BY … HAVING COUNT(*)>1`), accepted (`WHERE col NOT IN (...)`), **FK = LEFT JOIN parent WHERE parent.id IS NULL**. ⭐⭐
- **Custom tests** = your own SQL for business rules (e.g. paid ≤ allowed). ⭐
- **Fix failures at the SOURCE data**, not in dbt (dbt = transform only).
- `dbt test --select <model>` runs tests; `dbt build` runs seeds+models+tests together.
- **(Event note, not exam):** Snowflake AI-features event attended by trainer; session to come.

*End of Class 38 notes. dbt tests deep-dive: the 4 generic tests (=constraints), custom business tests, and the underlying validation queries (trainer flagged the FK/CHECK validation SQL as interview-askable; constraint enforcement overlaps the exam). This also covers the dbt-tests hands-on we had parked.*
