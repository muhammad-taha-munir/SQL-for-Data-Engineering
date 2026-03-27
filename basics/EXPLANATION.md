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