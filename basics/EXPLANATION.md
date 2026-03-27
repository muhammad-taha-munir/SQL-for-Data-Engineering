# SQL Basics — Explanation Guide

This file documents every query written in the `basics/` folder with
detailed explanations. Use this as a personal reference and revision guide.

> **Database Used:** All queries in this folder are based on the practice database
> located in `databases/Basic Database/`. Set it up first before running any queries.
> Refer to `GUIDE.md` for setup instructions.

### Reference Tables

**customers**
| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Germany | 350   |
| 2  | John       | USA     | 900   |
| 3  | Georg      | UK      | 750   |
| 4  | Martin     | Germany | 500   |
| 5  | Peter      | USA     | 0     |

**orders**
| order_id | customer_id | order_date | sales |
|----------|-------------|------------|-------|
| 1001     | 1           | 2021-01-11 | 35    |
| 1002     | 2           | 2021-04-05 | 15    |
| 1003     | 3           | 2021-06-18 | 20    |
| 1004     | 6           | 2021-08-31 | 10    |

---

## Basic SELECT Queries

### Retrieve All Columns from a Table
**File:** `select_customers.sql` | `select_orders.sql`

To retrieve every column from a table use `*` (asterisk):
```sql
SELECT *
FROM customers;
```
```sql
SELECT *
FROM orders;
```

`*` means "give me all columns" — SQL will return every field available
in that table.

---

### Retrieve Specific Columns
**File:** `select_specific_columns.sql`

Instead of pulling all columns you can specify exactly which ones you want:
```sql
SELECT
    first_name,
    country,
    score
FROM customers;
```

This returns only the `first_name`, `country`, and `score` columns from
the `customers` table. This is better practice than `SELECT *` because:
- You only get the data you actually need
- Queries run faster on large datasets
- Output is cleaner and easier to read

---

## Filtering Data with WHERE

The `WHERE` clause filters rows based on a condition.
Only rows that meet the condition are returned.

---

### Filter Customers by Score
**File:** `filter_customers_by_score.sql`
```sql
SELECT *
FROM customers
WHERE score != 0;
```

`!=` means "not equal to". This query returns all customers whose score
is not 0 — essentially filtering out inactive or unscored customers.

**Result:** Returns all customers except Peter (score = 0).

---

### Filter Customers by Country
**File:** `filter_customers_by_country.sql`
```sql
SELECT *
FROM customers
WHERE country = 'Germany';
```

This returns all columns for every customer located in Germany.
Text values in SQL are always wrapped in single quotes `' '`.

**Result:** Returns Maria and Martin.

---

### Retrieve Specific Columns with a Filter
**File:** `german_customers_name_country.sql`
```sql
SELECT
    first_name,
    country
FROM customers
WHERE country = 'Germany';
```

This combines two concepts — selecting specific columns AND filtering rows.
Only `first_name` and `country` are returned, and only for customers from Germany.
This is more efficient than `SELECT *` when you only need certain fields.

---

### Key Takeaway
`WHERE` always comes after `FROM`. The order matters in SQL:
```sql
SELECT  columns
FROM    table
WHERE   condition;
```

---

## Sorting Data with ORDER BY

The `ORDER BY` clause sorts the result set based on one or more columns.
It always comes after `WHERE`.

---

### Sort by Highest Score First
**File:** `select_customers_highest_score_first.sql`
```sql
SELECT *
FROM customers
ORDER BY score DESC;
```

`DESC` stands for descending — highest value comes first.
Useful when you want to see top performers or best results at the top.

**Result:** John (900), Georg (750), Martin (500), Maria (350), Peter (0)

---

### Sort by Lowest Score First
**File:** `select_customers_lowest_score_first.sql`
```sql
SELECT *
FROM customers
ORDER BY score;
```

When you don't specify `DESC`, SQL defaults to `ASC` (ascending) —
lowest value comes first. These two are identical in result:
```sql
ORDER BY score
ORDER BY score ASC
```

Writing `ASC` is optional but makes your code more readable.

**Result:** Peter (0), Maria (350), Martin (500), Georg (750), John (900)

---

### Sorting with Multiple Columns
**File:** `sorting_with_repeated_values.sql`
```sql
SELECT *
FROM customers
ORDER BY
    country ASC,
    score DESC;
```

You can sort by more than one column. SQL will first sort by `country`
alphabetically, then within each country sort by `score` highest to lowest.
This is most useful when your data has repeated values in the first column.

**Result:**
| first_name | country | score |
|------------|---------|-------|
| Martin     | Germany | 500   |
| Maria      | Germany | 350   |
| Georg      | UK      | 750   |
| John       | USA     | 900   |
| Peter      | USA     | 0     |

---

### Key Takeaway
```sql
SELECT  columns
FROM    table
WHERE   condition
ORDER BY column ASC/DESC;
```

`ORDER BY` always comes at the end.

---

## Aggregations with GROUP BY

Aggregation functions perform calculations on a group of rows and return
a single result per group. They are always used together with `GROUP BY`.

---

### How GROUP BY Works

When you use `GROUP BY country`, SQL groups the rows like this behind the scenes:
```
Germany → Maria (350), Martin (500)
UK      → Georg (750)
USA     → John (900), Peter (0)
```

Then the aggregation function runs on each group separately.

---

### The Execution Order

SQL does not run top to bottom like you read it.
The actual execution order is:
```
1. FROM      → get the table
2. GROUP BY  → group the rows by the specified column
3. SELECT    → apply aggregation on each group and return result
```

This is why you cannot use an alias defined in `SELECT` inside `WHERE` —
`WHERE` runs before `SELECT` in the execution order.

---

### Find Total Score for Each Country
**File:** `find_total_score_by_country.sql`
```sql
SELECT
    country,
    SUM(score) AS total_score
FROM customers
GROUP BY country;
```

**Result:**
| country | total_score |
|---------|-------------|
| Germany | 850         |
| UK      | 750         |
| USA     | 900         |

`SUM(score)` adds up all scores within each country group.
`AS total_score` is an **alias** — it renames the column header in the
output only. It does not change the database, and cannot be referenced
in other queries.

---

### Find Total Score and Total Customers for Each Country
**File:** `find_total_score_and_customers_by_country.sql`
```sql
SELECT
    country,
    SUM(score)  AS total_score,
    COUNT(id)   AS total_customers
FROM customers
GROUP BY country;
```

**Result:**
| country | total_score | total_customers |
|---------|-------------|-----------------|
| Germany | 850         | 2               |
| UK      | 750         | 1               |
| USA     | 900         | 2               |

`COUNT(id)` counts how many rows exist in each group.
You can stack multiple aggregation functions in the same query —
each one runs independently on the same groups.

---

### Key Takeaway
```sql
SELECT   columns, AGG_FUNCTION(column) AS alias
FROM     table
WHERE    condition
GROUP BY column
ORDER BY column ASC/DESC;
```

Any column in `SELECT` that is **not** inside an aggregation function
**must** appear in `GROUP BY`. Otherwise SQL will throw an error.

---

## Filtering Groups with HAVING

`HAVING` is used to filter **groups** after aggregation.
It works like `WHERE` but for aggregated results — you cannot use `WHERE`
to filter the result of `SUM()`, `COUNT()`, `AVG()` etc. That is what
`HAVING` is for.

---

### The Execution Order with HAVING

SQL executes clauses in this order:
```
1. FROM      → get the table
2. WHERE     → filter individual rows (before grouping)
3. GROUP BY  → group the remaining rows
4. HAVING    → filter the groups (after aggregation)
5. SELECT    → return the final result
```

This order is critical to understand — `WHERE` filters rows before
grouping, `HAVING` filters groups after aggregation.

---

### Filter Countries by Total Score
**File:** `having_clause.sql`
```sql
SELECT
    country,
    SUM(score) AS score_greater_than_800
FROM customers
GROUP BY country
HAVING SUM(score) > 800;
```

**Result:**
| country | score_greater_than_800 |
|---------|------------------------|
| Germany | 850                    |
| USA     | 900                    |

UK is excluded because its total score (750) does not meet the condition.
`HAVING SUM(score) > 800` runs after grouping and filters out any group
whose total score is 800 or below.

---

### Using WHERE and HAVING Together
**File:** `having_clause.sql`

You can filter twice — once before grouping with `WHERE` and once after
grouping with `HAVING`:
```sql
SELECT
    country,
    SUM(score)
FROM customers
WHERE score > 400
GROUP BY country
HAVING SUM(score) > 800;
```

Here is what happens step by step using our reference table:

**Step 1 — WHERE filters individual rows first:**

Only rows where `score > 400` pass through:
| id | first_name | country | score |
|----|------------|---------|-------|
| 2  | John       | USA     | 900   |
| 3  | Georg      | UK      | 750   |
| 4  | Martin     | Germany | 500   |

Maria (350) and Peter (0) are excluded before any grouping happens.

**Step 2 — GROUP BY groups the remaining rows:**
```
Germany → Martin (500)
UK      → Georg (750)
USA     → John (900)
```

**Step 3 — HAVING filters the groups:**

Only groups with `SUM(score) > 800` pass through:
| country | SUM(score) |
|---------|------------|
| USA     | 900        |

Germany (500) and UK (750) are excluded because neither meets the HAVING condition.

---

### Task — Average Score by Country
**File:** `having_task.sql`

Find the average score for each country considering only customers
with a score not equal to 0, and only show countries where the
average is above 430:
```sql
SELECT
    country,
    AVG(score) AS avg_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430;
```

**Step 1 — WHERE removes customers with score = 0:**

Peter (0) is excluded. Remaining rows:
| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Germany | 350   |
| 2  | John       | USA     | 900   |
| 3  | Georg      | UK      | 750   |
| 4  | Martin     | Germany | 500   |

**Step 2 — GROUP BY groups by country:**
```
Germany → Maria (350), Martin (500) → AVG = 425
UK      → Georg (750)               → AVG = 750
USA     → John (900)                → AVG = 900
```

**Step 3 — HAVING filters groups where AVG > 430:**
| country | avg_score |
|---------|-----------|
| UK      | 750       |
| USA     | 900       |

Germany is excluded because its average (425) does not exceed 430.

---

### Key Takeaway

| Clause  | Filters        | Runs At         |
|---------|----------------|-----------------|
| WHERE   | Individual rows | Before grouping |
| HAVING  | Groups          | After grouping  |

Use `WHERE` to filter raw data and `HAVING` to filter aggregated results.
You can use both in the same query — `WHERE` always comes before `GROUP BY`
and `HAVING` always comes after.
```sql
SELECT   columns, AGG_FUNCTION(column) AS alias
FROM     table
WHERE    row_condition
GROUP BY column
HAVING   group_condition
ORDER BY column ASC/DESC;
```

---

## Removing Duplicates with DISTINCT

`DISTINCT` returns only unique values from a column, removing any repetition
from the result set.

---

### Return Unique List of Countries
**File:** `distinct_unique_values.sql`
```sql
SELECT DISTINCT
    country
FROM customers;
```

**Result:**
| country |
|---------|
| Germany |
| USA     |
| UK      |

Without `DISTINCT` the query would return 5 rows — Germany appearing twice
and USA appearing twice because Maria, Martin share Germany and John, Peter
share USA. `DISTINCT` collapses those into one row per unique value.

---

### Bad Habit — Using DISTINCT Unnecessarily
```sql
SELECT DISTINCT id
FROM customers;
```

`id` is already unique by nature — every customer has a different id.
Using `DISTINCT` here wastes resources because SQL still has to scan and
compare every value even when there is nothing to deduplicate.

**Rule:** Only use `DISTINCT` when you can actually see duplication or
repetition in your data. If a column is already unique, skip it.

---

### Key Takeaway

- `DISTINCT` is placed right after `SELECT`
- It applies to the entire row, not just one column
- It can slow down queries on large datasets because SQL has to compare every value
- Only use it when duplication is confirmed — not as a default habit

---

## Limiting Results with TOP

`TOP` restricts the number of rows returned by a query.
In Microsoft SQL Server this is `TOP` — other databases like MySQL use `LIMIT`
for the same purpose.

---

### Basic Usage
**File:** `top_limit_basics.sql`
```sql
SELECT TOP 3 *
FROM customers;
```

**Result:** Returns the first 3 rows from the customers table as they are
stored — no particular order unless you specify `ORDER BY`.

---

### Retrieve Top 3 Customers with Highest Score
**File:** `top_limit_tasks.sql`
```sql
SELECT TOP 3 *
FROM customers
ORDER BY score DESC;
```

**Result:**
| id | first_name | country | score |
|----|------------|---------|-------|
| 2  | John       | USA     | 900   |
| 3  | Georg      | UK      | 750   |
| 4  | Martin     | Germany | 500   |

`ORDER BY score DESC` sorts highest first, then `TOP 3` takes only the
first 3 rows from that sorted result.

---

### Retrieve Bottom 2 Customers with Lowest Score
**File:** `top_limit_tasks.sql`
```sql
SELECT TOP 2 *
FROM customers
ORDER BY score ASC;
```

**Result:**
| id | first_name | country | score |
|----|------------|---------|-------|
| 5  | Peter      | USA     | 0     |
| 1  | Maria      | Germany | 350   |

`ORDER BY score ASC` sorts lowest first, then `TOP 2` takes only the
first 2 rows. This is how you get the bottom performers.

---

### Get the Two Most Recent Orders
**File:** `top_limit_tasks.sql`
```sql
SELECT TOP 2 *
FROM orders
ORDER BY order_date DESC;
```

**Result:**
| order_id | customer_id | order_date | sales |
|----------|-------------|------------|-------|
| 1004     | 6           | 2021-08-31 | 10    |
| 1003     | 3           | 2021-06-18 | 20    |

`ORDER BY order_date DESC` sorts the most recent date first, then `TOP 2`
returns only the two latest orders.

---

### Key Takeaway

`TOP` without `ORDER BY` returns rows in no guaranteed order — the result
depends on how SQL Server stored the data internally. Always pair `TOP`
with `ORDER BY` to get meaningful results.
```sql
SELECT TOP n *
FROM table
ORDER BY column DESC/ASC;
```

| Goal                  | Order       |
|-----------------------|-------------|
| Top n highest values  | DESC        |
| Top n lowest values   | ASC         |
| Most recent records   | DESC (date) |
| Oldest records        | ASC (date)  |

---

## Coding Order vs Execution Order

These are two different things in SQL that beginners often confuse.
**Coding Order** is how you write the query.
**Execution Order** is how SQL actually runs it internally.

> For a visual representation of this concept refer to
> `Coding order vs Execution Order.png` in the `basics/` folder.

---

### Coding Order — How You Write It

This is the order you must follow when typing a query:
```sql
SELECT DISTINCT TOP 2
    col1,
    SUM(col2)
FROM table
WHERE col = 10
GROUP BY col1
HAVING SUM(col2) > 30
ORDER BY col1 ASC;
```

| Step | Clause        |
|------|---------------|
| 1    | SELECT        |
| 2    | FROM          |
| 3    | WHERE         |
| 4    | GROUP BY      |
| 5    | HAVING        |
| 6    | ORDER BY      |
| 7    | TOP           |

---

### Execution Order — How SQL Runs It

Even though you write `SELECT` first, SQL does not start there.
Internally it runs in this order:

| Step | Clause          | What it does                              |
|------|-----------------|-------------------------------------------|
| 1    | FROM            | Gets the table from the database          |
| 2    | WHERE           | Filters individual rows                   |
| 3    | GROUP BY        | Groups the remaining rows                 |
| 4    | HAVING          | Filters the groups                        |
| 5    | SELECT DISTINCT | Selects columns and removes duplicates    |
| 6    | ORDER BY        | Sorts the result                          |
| 7    | TOP             | Limits the number of rows returned        |

---

### Why This Matters

Understanding execution order explains several common confusions:

- **Why you can't use a SELECT alias in WHERE** — `WHERE` runs before
  `SELECT` so the alias doesn't exist yet at that point
- **Why HAVING comes after GROUP BY** — it needs the groups to already
  exist before it can filter them
- **Why TOP comes last** — SQL sorts and filters everything first, then
  cuts the result down to the number you specified

---

### Key Takeaway

You write SQL in **Coding Order** but SQL executes it in **Execution Order**.
These two are completely different sequences. Knowing execution order helps
you write correct queries and understand why certain things work or fail.