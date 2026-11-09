# Class 47 — Unstructured Data (PDF → Table) with Cortex AI Functions, Cortex Code Demo & Career Q&A

**Snowflake — Class 47 Notes**
*Sara — SnowPro Core preparation*

> 🟡 **Mostly NOT SnowPro Core.** This class is a **demo of Snowflake's Cortex AI features** (reading a PDF invoice into a table) plus a long career/logistics Q&A. Treat it as **job and interview knowledge**, not exam material. The only exam-adjacent content is the vocabulary in §1 (structured / semi-structured / unstructured) and recaps of stages.
>
> **Honest labelling:**
> - **§1** is light exam vocabulary.
> - **§2–§4** (Cortex AI functions, Cortex Code, GitHub Copilot/MCP) are **AI-features / career content**.
> - **§5** (career, resume, Python sessions, badges) is **logistics**, but it contains **things you asked me to flag**.
> - **The audio is poor and the function names are garbled** by the transcription ("pass document", "a-complete", "A extract"). I've written them as the Snowflake functions they almost certainly are (`AI_PARSE_DOCUMENT`, `AI_COMPLETE`, `AI_EXTRACT`) and marked that as **my reading, not a quote**. Check the exact names in Snowflake's documentation before using them anywhere.
> - **He did not run the PDF functions on a trial account**; they failed there (see §2). Everything worked only in **his Cortex-enabled account**.
>
> **Things he said that matter to you (flagged as you asked):**
> - 🎓 **Certification mention [~61:20–61:30]:** talking about badges and resumes, he said that if you plan to do a certification, he named **SnowPro**, and "if SnowPro is enough, that is fine." The audio is rough, so I read this as **"SnowPro Core is a sensible one to aim for."** It is not a detailed plan.
> - 🎓 **A different certification [~33:00–34:50]:** he suggested a **GitHub Copilot certification, which the audio gives as "DH 300"**. I believe the real code is **GH-300**, but I can't confirm that from the audio. He said it is good to have **since you're working**, meaning for people already in jobs. It is a **separate, optional** certification and is not part of your SnowPro plan.
> - 🐍 **Python sessions did not happen as promised.** A student said that on **Friday** Krishna promised to **share the Python link by 4 PM** and **never did** [~64:16–64:32]. Krishna said he had "pinged it in the group." **That answers your earlier question: I can't tell you the sessions ran.** Check your group and ask him.
> - 📺 He said he'd **upload the pending videos and documents** "within half an hour to an hour" [~68:27–69:07] and asked students waiting for the **resume review** to **ping him personally**.
> - 💼 For **resumes and job applications**, he said there won't be a **class**, but he'll **connect individually**: "send your resume," and he'll show a sample [~62:46–63:36].
> - 🏅 **Badges:** he said to **paste your badge link in your resume**, and that one student had completed about **four**. Same free badges as Class 43.
> - 🔑 **Another Cortex-enabled account** was shared with students (username/password sent separately). **I recorded no credentials.** Same caution as last time (§6).

---

## 1. Structured, semi-structured and unstructured data ⭐ (exam vocabulary)

| Type | Examples | In Snowflake |
|---|---|---|
| **Structured** | tables, CSV | regular columns |
| **Semi-structured** | JSON, Parquet, XML, Avro | `VARIANT` + `FLATTEN` (Classes 5–8) |
| **Unstructured** | **PDFs, images**, audio | stored as **files in a stage**; you read them with functions |

- ⭐ Recap that matters for the exam: unstructured files sit in a **stage** (internal or external) and you can list them with a **directory table** (Class 30).
- He used an **internal named stage** for the PDF and uploaded the file through **Snowsight → Database Explorer → the stage → upload**.

## 2. The PDF-to-table demo (Cortex AI functions: NOT exam)

**The goal:** turn a PDF invoice (invoice number, date, currency, line items, subtotal, tax, total) into **rows in a table**.

**The flow he walked through:**
1. Upload the PDF to the stage.
2. Create **two tables**: a **raw** table (file name, the parsed JSON, any error) and a **main** table with the invoice fields.
3. **Parse the document** with a Snowflake function. It returns **JSON**. In the JSON, the text lives under a `content` key.
4. **Ask a model** (he used a Llama model; the UI lists others such as Claude and GPT) to pull out the fields you want, by giving it the text, a prompt and a **response format** listing the output fields.
5. Insert the result into the table, avoiding duplicates.

**The three functions** (my reading of the garbled audio, not his exact words):
- **Document parsing:** `AI_PARSE_DOCUMENT` (older name `SNOWFLAKE.CORTEX.PARSE_DOCUMENT`). Takes a **stage file** and returns JSON.
- **Completion:** `AI_COMPLETE` (older `SNOWFLAKE.CORTEX.COMPLETE`). Parameters he named: **model**, **prompt**, **response format**.
- **Extraction:** `AI_EXTRACT`. A later step in the Cortex Code demo that pulls structured fields (**header** values plus **line items**) straight from a PDF.

**Trial limit (important):** running the parse function on your trial gave an error that the function is **not available for trial accounts**. His explanation: these are **costly operations**, so trials don't get them. That fits what he said in Class 46.

**Line items vs header (a modelling point):** an invoice has **header** fields (invoice number, date, currency) and **line items** (description, quantity, unit price, amount). With many items you need **two tables**, one for headers and one for line items. He regenerated the PDF with **5 line items** to show this.

## 3. Cortex Code ("Coco") demo (NOT exam)

- He gave **Cortex Code** (the Snowsight AI assistant) one prompt describing the requirement. It made a **plan first** ("plan mode"), then asked permission step by step and created the **warehouse, database, stage, tables**, loaded the file, ran the extraction and inserted the rows.
- **His warning, worth keeping [~43:06–43:48]:** *you must understand what it generates.* The output is **not deterministic**, and **you can't use it safely if you can't read the SQL.** That fits how you learn.
- **Cortex Analyst vs Cortex Search (a student question) [~58:45–59:30]:** he said **Cortex Analyst is for structured data**, **Cortex Search** is a different feature, and **neither works on a trial**. He called Cortex a **"different course"** from the core Snowflake material.

## 4. GitHub Copilot, MCP and agents (NOT exam, career context)

- He recommended learning **GitHub Copilot** (and its certification, see the flags above) because many companies will give developers a Copilot licence.
- **MCP (Model Context Protocol)** lets an AI agent connect to tools such as **GitHub, Jira and Confluence**. His example: a new joiner reads the **Jira story**, the **Confluence docs** and the **GitHub code** through MCP, and the agent explains what to change.
- **Security note he made:** some companies **don't allow certain models** (he said Claude is blocked at some), so you only use their approved models.
- He said he attended a Snowflake event last week where a **multi-agent** system was built. This is the same event line as Class 46.

## 5. Career, resume and logistics (the flagged items are at the top)

- **Resume:** send it to him; he'll share a sample. Your resume plan from the handover is separate and already agreed.
- **Applying for jobs:** a student asked for a class on **how and where to apply**. He said **no class**, but he'll **connect individually**.
- **Pending course content:** a student asked for a **complete end-to-end flow** (S3 → stage → stream → task → final table with validations, full vs incremental load, **SCD Type 1 and Type 2**). Krishna said **that flow was already covered** and repeating it all would mean rebuilding everything. Another student said **SCD Type 1/Type 2 still needs a discussion**. Left unresolved. You already did SCD2 in Classes 23–24.
- **Recordings:** he promised to upload all missing videos and documents to the Drive "within an hour."
- **Next class:** "tomorrow."

## 6. Safety note on the shared account

He shared an account with Cortex enabled and said some people can use it. **I recorded no username or password.** Before using it:
- Treat it as **someone else's account**. You don't control it and others use it.
- **Don't change the password** and don't create anything you care about there.
- **Never put credentials in your notes or the repo**, which is public.
- Using it is optional. None of it is on the exam.

## 7. Previewed / still owed

- **QAS** (still not taught), **procedures and functions** (a week), possibly more of the **agents lab**.
- **The Python link** (see the flags above).
- **Last class:** he still has not said when the Snowflake course ends.

## 8. Cheat-sheet / quick recall

- **Unstructured = files in a stage** (PDFs, images), read with functions. Directory table lists them (Class 30). ⭐
- **Structured / semi-structured / unstructured** definitions. ⭐
- *(job knowledge)* Cortex AI functions: parse document → JSON; complete (model + prompt + response format); extract fields. Names are my reading of garbled audio, so verify them.
- Cortex AI functions are **not available on trial accounts** (he saw the error).
- Header + line items → **two tables**.
- *(job knowledge)* Always read what an AI assistant generates. It isn't deterministic.
- 🎓 He named **SnowPro** as a sensible certification and **GitHub Copilot (GH-300?)** as an optional extra.
- 🐍 Python link was **not shared on Friday**. Ask him.

*End of Class 47 notes. A Cortex AI demo (PDF to table), an AI-assistant and MCP talk, and a career Q&A. Very little is SnowPro Core content; the certification mentions and promised follow-ups are flagged at the top.*
