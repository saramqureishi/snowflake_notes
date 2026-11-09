# Class 47 — Unstructured Data (PDF → Table) with Cortex AI Functions, Cortex Code Demo & Career Q&A

**Snowflake — Class 47 Notes**
*Sara — SnowPro Core preparation*

> 🟠 **Relabelled 9 Nov. I first called this class "mostly not SnowPro Core", which was too strong.** It is a **demo of Snowflake's Cortex AI features** (reading a PDF invoice into a table) plus a career/logistics Q&A. Snowflake's own SnowPro Core **COF-C03** page lists "use structured, semi-structured, and unstructured data" as a tested ability, and third-party C03 guides say the exam added **Cortex AI** at a conceptual "which tool for which job" level. I could not open Snowflake's official exam guide PDF, so **check its topic list**. The hands-on syntax he showed is job/interview depth, not exam depth.
>
> **Honest labelling:**
> - **§1** is **exam content** (unstructured data is a stated C03 objective).
> - **§2** (Cortex AI functions) is **exam-relevant at concept level**. **§3–§4** (Cortex Code, GitHub Copilot/MCP) are **career/AI-assistant content**; I found no evidence of them in the C03 guides.
> - **§5** (career, resume, Python sessions, badges) is **logistics**, but it contains **things you asked me to flag**.
> - **The audio is poor and the function names are garbled** by the transcription ("pass document", "a-complete", "A extract"). I wrote them as the functions they most likely are. **Cross-checked 9 Nov:** `AI_PARSE_DOCUMENT`, `AI_COMPLETE` and `AI_EXTRACT` all exist in Snowflake's Cortex AI Functions documentation, and `AI_EXTRACT` also appears in the trainer's own SQL file. What he actually typed is still my reading.
> - **The PDF functions failed on the trial account** (see §2). Everything worked only in **his Cortex-enabled account**. **You confirmed the same on 9 Nov:** `SNOWFLAKE.CORTEX.SENTIMENT` on your trial returned "AI function SENTIMENT is not available for trial accounts."
>
> **Things he said that matter to you (flagged as you asked):**
> - 🎓 **Certification mention [~61:20–61:30]:** talking about badges and resumes, he said that if you plan to do a certification, he named **SnowPro**, and "if SnowPro is enough, that is fine." The audio is rough, so I read this as **"SnowPro Core is a sensible one to aim for."** It is not a detailed plan.
> - 🎓 **A different certification [~33:00–34:50]:** he suggested a **GitHub Copilot certification, which the audio gives as "DH 300"**. I believe the real code is **GH-300**, but I can't confirm that from the audio. He said it is good to have **since you're working**, meaning for people already in jobs. It is a **separate, optional** certification and is not part of your SnowPro plan.
> - 🐍 **Python sessions did not happen as promised.** A student said that on **Friday** Krishna promised to **share the Python link by 4 PM** and **never did** [~64:16–64:32]. Krishna said he had "pinged it in the group." **That answers your earlier question: I can't tell you the sessions ran.** Check your group and ask him. **Update, 9 Nov (his WhatsApp message):** the Python sessions are **free** and he will **create a new group** for people who are interested. He still has not said what they cover.
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

## 2. The PDF-to-table demo (Cortex AI functions: concept = exam-relevant, syntax = job depth)

**The goal:** turn a PDF invoice (invoice number, date, currency, line items, subtotal, tax, total) into **rows in a table**.

**The flow he walked through:**
1. Upload the PDF to the stage.
2. Create **two tables**: a **raw** table (file name, the parsed JSON, any error) and a **main** table with the invoice fields.
3. **Parse the document** with a Snowflake function. It returns **JSON**. In the JSON, the text lives under a `content` key.
4. **Ask a model** (he used a Llama model; the UI lists others such as Claude and GPT) to pull out the fields you want, by giving it the text, a prompt and a **response format** listing the output fields.
5. Insert the result into the table, avoiding duplicates.

**The three functions** (my reading of the garbled audio; the names are confirmed in Snowflake's docs):
- **Document parsing:** `AI_PARSE_DOCUMENT` (older name `SNOWFLAKE.CORTEX.PARSE_DOCUMENT`). Takes a **stage file** and returns JSON.
- **Completion:** `AI_COMPLETE` (older `SNOWFLAKE.CORTEX.COMPLETE`). Parameters he named: **model**, **prompt**, **response format**.
- **Extraction:** `AI_EXTRACT`. A later step in the Cortex Code demo that pulls structured fields (**header** values plus **line items**) straight from a PDF.

**Trial limit (important):** running the parse function on your trial gave an error that the function is **not available for trial accounts**. His explanation: these are **costly operations**, so trials don't get them. That fits what he said in Class 46.

**Line items vs header (a modelling point):** an invoice has **header** fields (invoice number, date, currency) and **line items** (description, quantity, unit price, amount). With many items you need **two tables**, one for headers and one for line items. He regenerated the PDF with **5 line items** to show this.

## 2b. What to know about Cortex for the exam (concept level)

This block is from Snowflake's docs and third-party C03 guides, **not from the class**. Verify it against the official exam guide.

- **Cortex AI Functions** run LLMs from SQL **inside Snowflake's security perimeter**, so data is not sent out. Task-specific functions in the docs include `AI_COMPLETE`, `AI_CLASSIFY`, `AI_FILTER`, `AI_EXTRACT`, `AI_SENTIMENT`, `AI_SUMMARIZE`, `AI_TRANSLATE`, `AI_PARSE_DOCUMENT`, `AI_EMBED` and `AI_REDACT`. Older `SNOWFLAKE.CORTEX.*` names (`COMPLETE`, `SUMMARIZE`, `SENTIMENT`, `TRANSLATE`, `EXTRACT_ANSWER`) still appear in third-party guides, so the exam may use either style.
- **Access:** per the docs, the role needs the `USE AI FUNCTIONS` account privilege plus the `CORTEX_USER` or `AI_FUNCTIONS_USER` database role.
- **Cortex Search:** semantic (meaning-based) search over text, used to retrieve passages for retrieval-augmented generation (RAG).
- **Cortex Analyst:** natural-language questions over **structured** data, answered with SQL using a **semantic model**. Krishna said the same in class: Analyst is for structured data.
- **Not available on trial accounts** (he saw the error; you saw it too).
- **Cost:** AI functions use credits. A comment in his SQL file says AI_EXTRACT is billed per token.

## 3. Cortex Code ("Coco") demo (career / AI-assistant content)

- He gave **Cortex Code** (the Snowsight AI assistant) one prompt describing the requirement. It made a **plan first** ("plan mode"), then asked permission step by step and created the **warehouse, database, stage, tables**, loaded the file, ran the extraction and inserted the rows.
- **His warning, worth keeping [~43:06–43:48]:** *you must understand what it generates.* The output is **not deterministic**, and **you can't use it safely if you can't read the SQL.** That fits how you learn.
- **Cortex Analyst vs Cortex Search (a student question) [~58:45–59:30]:** he said **Cortex Analyst is for structured data**, **Cortex Search** is a different feature, and **neither works on a trial**. He called Cortex a **"different course"** from the core Snowflake material.

## 4. GitHub Copilot, MCP and agents (career context; not found in the C03 guides I read)

- He recommended learning **GitHub Copilot** (and its certification, see the flags above) because many companies will give developers a Copilot licence.
- **MCP (Model Context Protocol)** lets an AI agent connect to tools such as **GitHub, Jira and Confluence**. His example: a new joiner reads the **Jira story**, the **Confluence docs** and the **GitHub code** through MCP, and the agent explains what to change.
- **Security note he made:** some companies **don't allow certain models** (the audio says "cloud", which I read as Claude; that is a guess), so you only use their approved models.
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
- Using it is optional. The hands-on there is not needed for the exam; the Cortex concepts are in §2b instead.

## 7. Previewed / still owed

- **QAS** (still not taught), **procedures and functions** (a week), possibly more of the **agents lab**.
- **The Python link** (see the flags above).
- **Last class:** he still has not said when the Snowflake course ends.

## 8. Cheat-sheet / quick recall

- **Unstructured = files in a stage** (PDFs, images), read with functions. Directory table lists them (Class 30). ⭐
- **Structured / semi-structured / unstructured** definitions. ⭐
- Cortex AI functions (concept = exam-relevant): run LLMs from SQL inside Snowflake. Names confirmed in docs: `AI_PARSE_DOCUMENT` (document → JSON), `AI_COMPLETE` (model + prompt + response format), `AI_EXTRACT` (fields), `AI_SENTIMENT`, `AI_SUMMARIZE`, `AI_TRANSLATE`. ⭐
- **Cortex Search** = semantic search for RAG; **Cortex Analyst** = natural language → SQL over structured data. ⭐ (from docs/guides)
- Cortex AI functions are **not available on trial accounts** (he saw the error; you saw it on 9 Nov).
- Header + line items → **two tables**.
- *(job knowledge)* Always read what an AI assistant generates. It isn't deterministic.
- 🎓 He named **SnowPro** as a sensible certification and **GitHub Copilot (GH-300?)** as an optional extra.
- 🐍 Python link was **not shared on Friday**. Ask him.

*End of Class 47 notes. A Cortex AI demo (PDF to table), an AI-assistant and MCP talk, and a career Q&A. The syntax is job-depth; the Cortex concepts (§2b) and the unstructured-data objective are exam-relevant. The certification mentions and promised follow-ups are flagged at the top.*
