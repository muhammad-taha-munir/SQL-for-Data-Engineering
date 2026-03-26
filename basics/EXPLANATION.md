## Basic SELECT Queries

### Retrieve All Columns from a Table
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
SELECT columns
FROM table
WHERE condition;
```

---

## Sorting Data with ORDER BY

The `ORDER BY` clause sorts the result set based on one or more columns.
It always comes last in the query, after `WHERE`.

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

Writing `ASC` is optional but can make your code more readable.

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
alphabetically, and then within each country sort by `score` from highest
to lowest. This makes the most sense when your data has repeated values
in the first column — for example multiple customers from the same country.

---

### Key Takeaway
The full query order so far:
```sql
SELECT columns
FROM table
WHERE condition
ORDER BY column ASC/DESC;
```

`ORDER BY` always comes at the end.