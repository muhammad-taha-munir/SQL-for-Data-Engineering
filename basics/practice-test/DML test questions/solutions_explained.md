# DML — Practice Test Solutions

**Database:** Basic Database (`MyDatabase`)

---

## Section 1 — INSERT

### Q1. Insert two rows into the persons table.
```sql
INSERT INTO persons (id, person_name, birth_date, phone)
VALUES
    (10, 'Ali Hassan', '1995-06-15', '03001234567'),
    (11, 'Sara Khan', NULL, '03119876543');
```

Both rows are inserted in a single statement separated by a comma.
Sara Khan's `birth_date` is `NULL` because the column allows it.
Phone values are wrapped in single quotes because the column is `VARCHAR`.

> **Important:** Always wrap `VARCHAR` values in single quotes. Phone
> numbers without quotes are treated as integers by SQL and the leading
> zero will be dropped — `03001234567` becomes `3001234567`.

---

### Q2. Insert into employees without specifying column names.
```sql
INSERT INTO employees
VALUES (5, 'Ahmed', 'Raza', '2023-01-10', 'ahmed@gmail.com', '03211112233');
```

When column names are omitted every value must be provided in the exact
order the columns were defined in `CREATE TABLE`:
```
id → first_name → last_name → hire_date → email → phone
```

If you are unsure of the column order always specify column names explicitly
to avoid inserting values into the wrong columns.

---

### Q3. Copy filtered customers into persons.
```sql
INSERT INTO persons (id, person_name, birth_date, phone)
SELECT
    id,
    first_name,
    NULL,
    'Unknown'
FROM customers
WHERE score > 400;
```

**Customers with score > 400 from reference table:**
| id | first_name | score |
|----|------------|-------|
| 2  | John       | 900   |
| 3  | Georg      | 750   |
| 4  | Martin     | 500   |

These three rows are copied into `persons`. Column mapping:

| customers column | persons column | Value used |
|-----------------|----------------|------------|
| `id` | `id` | Direct copy |
| `first_name` | `person_name` | Direct copy |
| *(no match)* | `birth_date` | `NULL` |
| *(no match)* | `phone` | `'Unknown'` |

`birth_date` has no matching column in `customers` so `NULL` is used.
`phone` is `NOT NULL` in `persons` so `'Unknown'` is used as a placeholder
instead of `NULL`.

---

## Section 2 — UPDATE

### Q4. Update score of customer with id 1 to 999.
```sql
UPDATE customers
    SET score = 999
WHERE id = 1;
```

**Before:** Maria | Germany | 350
**After:** Maria | Germany | 999

Only the row where `id = 1` is affected. All other rows remain unchanged.

---

### Q5. Update country and score for customer with id 4.
```sql
UPDATE customers
    SET score = 0,
        country = 'USA'
WHERE id = 4;
```

**Before:** Martin | Germany | 500
**After:** Martin | USA | 0

Two columns are updated in one statement by separating each assignment
with a comma inside `SET`.

---

### Q6. Update phone for all matching employees.
```sql
UPDATE employees
    SET phone = '00000000000'
WHERE phone = '03211112233';
```

This updates the phone for every employee whose current phone matches
`'03211112233'`. Both the `SET` value and the `WHERE` condition use
single quotes because `phone` is a `VARCHAR` column.

---

## Section 3 — DELETE

### Q7. Delete customer with id 3.
```sql
DELETE FROM customers
WHERE id = 3;
```

Only Georg (id = 3) is removed. All other rows remain untouched.
Always use `WHERE` to target specific rows — without it every row
in the table would be deleted.

---

### Q8. Delete orders where sales are less than or equal to 15.
```sql
DELETE FROM orders
WHERE sales <= 15;
```

**Deleted rows:**
| order_id | sales |
|----------|-------|
| 1002     | 15    |
| 1004     | 10    |

`<=` means less than or equal to — orders with sales of exactly 15
are also deleted, not just those below 15.

---

### Q9. Delete all rows from persons using DELETE.
```sql
DELETE FROM persons;
```

All rows are removed but the `persons` table structure remains intact.
Every deletion is logged row by row — on large tables this can be slow.

---

### Q10. Clear all rows from employees using TRUNCATE.
```sql
TRUNCATE TABLE employees;
```

All rows are removed instantly without row by row logging — much faster
than `DELETE` when clearing an entire table.

| | DELETE | TRUNCATE |
|-|--------|----------|
| Removes all rows | ✅ | ✅ |
| Can use WHERE | ✅ | ❌ |
| Row by row logging | ✅ | ❌ |
| Speed on large data | Slower | Faster |

---

## Section 4 — Mixed

### Q11. Insert, update then delete a customer.
```sql
-- Step 1: Insert
INSERT INTO customers (id, first_name, country, score)
VALUES (6, 'Zara', 'Germany', 600);

-- Step 2: Update
UPDATE customers
    SET score = 750
WHERE id = 6;

-- Step 3: Delete
DELETE FROM customers
WHERE id = 6;
```

**After INSERT:**
| id | first_name | country | score |
|----|------------|---------|-------|
| 6  | Zara       | Germany | 600   |

**After UPDATE:**
| id | first_name | country | score |
|----|------------|---------|-------|
| 6  | Zara       | Germany | 750   |

**After DELETE:** Row is permanently removed from the table.

The order of operations matters — you cannot update or delete a row
that has not been inserted yet.

---

## DML Summary

| Command | Purpose | Reversible |
|---------|---------|------------|
| `INSERT` | Add new rows | Yes — delete the rows |
| `UPDATE` | Modify existing rows | Yes — update again |
| `DELETE` | Remove specific rows | No |
| `TRUNCATE` | Clear entire table fast | No |

Always use `WHERE` with `UPDATE` and `DELETE`.
Always wrap `VARCHAR` values in single quotes.
Always `SELECT` before `UPDATE` or `DELETE` to confirm the right rows are targeted.