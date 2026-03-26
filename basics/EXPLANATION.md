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
