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