# Basics Guide

## Setting Up the Practice Database

The script for the basic practice database is available in the `databases/`
folder in this repository. Follow these steps to set it up:

1. Open **SQL Server Management Studio (SSMS)**
2. Click **New Query**
3. Paste the entire script into the query window
4. Click **Execute**
5. The database named `MyDatabase` will be created and ready to use

> **Note:** The database scripts in the `databases/` folder are saved with
> a `.sql` extension. You have two ways to open them:
> - **Right-click → Open with Notepad** — copy the script and paste it into
>   a new query window in SSMS manually
> - **Double-click the file** — if SSMS is installed and associated with `.sql`
>   files, it will open directly in SSMS with the script already loaded

---

## Selecting a Database

Before writing any queries you must select the database you want to work with.
There are two ways to do this:

**Option 1 — Using the dropdown:**
At the top of SSMS there is a dropdown showing all available databases on your
system. Simply click it and select `MyDatabase`.

**Option 2 — Using a query:**
```sql
USE MyDatabase;
```
Type this in the query window and click **Execute**. `MyDatabase` will become
your active database for all queries that follow.

---

## File Naming Convention

All query files in this folder use the `.sql` extension.
Files are named using this format:
```
action_tablename.sql
```

| File Name | Description |
|-----------|-------------|
| `select_customers.sql` | Retrieves all customer data |
| `select_orders.sql` | Retrieves all order data |
| `filter_customers_by_country.sql` | Filters customers by country |

The name tells you exactly what the query does without needing to open it.

---

## Folder Structure

Queries are organized into subfolders based on their category:

| Folder | Contents |
|--------|----------|
| `query-data/` | SELECT, WHERE, ORDER BY, TOP, DISTINCT, GROUP BY, HAVING |
| `DDL/` | CREATE, ALTER, DROP |
| `DML/` | INSERT, UPDATE, DELETE |
| `practice-test/` | Practice questions, solutions and explanations |

---

## Your First Query

Once `MyDatabase` is selected, try running this to retrieve all customer data:
```sql
SELECT * FROM customers;
```

This pulls every column and every row from the `customers` table.
The table name after `FROM` is essential — SQL needs to know exactly
which table to retrieve data from.

For a detailed breakdown of every query written in this folder refer to
`EXPLANATION.md`.