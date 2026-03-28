# Basics

This folder contains all foundational SQL queries and exercises written
using Microsoft SQL Server (T-SQL) as part of the Data Engineering learning roadmap.

---

## Folder Structure
```
basics/
├── query-data/             ← SELECT, WHERE, ORDER BY, TOP, DISTINCT, GROUP BY, HAVING
│   └── EXPLANATION.md      ← Explains all query-data scripts
├── DDL/                    ← Data Definition Language (CREATE, ALTER, DROP)
│   └── EXPLANATION.md      ← Explains all DDL scripts
├── DML/                    ← Data Manipulation Language (INSERT, UPDATE, DELETE)
│   └── EXPLANATION.md      ← Explains all DML scripts
├── practice-test/          ← Practice questions, solutions and explanations
├── GUIDE.md                ← How to set up the practice database
└── README.md               ← You are here
```

---

## What is Covered

### Query Data
Querying and retrieving data from tables using:
- `SELECT` — retrieve columns and static values
- `WHERE` — filter rows by condition
- `ORDER BY` — sort results
- `TOP` — limit number of rows returned
- `DISTINCT` — remove duplicate values
- `GROUP BY` — group rows for aggregation
- `HAVING` — filter aggregated groups

### DDL — Data Definition Language
Commands that define and manage the structure of the database:
- `CREATE` — create tables and databases
- `ALTER` — modify existing table structure
- `DROP` — delete tables and databases

### DML — Data Manipulation Language
Commands that manipulate the data inside tables:
- `INSERT` — add new rows
- `UPDATE` — modify existing rows
- `DELETE` — remove rows

---

## Database Used

All queries in this folder use the Basic practice database.
Refer to `GUIDE.md` for setup instructions before running any queries.

---

## How to Use

1. Set up the database by following `GUIDE.md`
2. Navigate to the relevant subfolder
3. Open any `.sql` file in SSMS
4. Make sure `MyDatabase` is selected
5. Execute the query and observe the results
6. Read the `EXPLANATION.md` inside that subfolder for a detailed breakdown