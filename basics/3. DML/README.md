# DML — Explanation Guide

This file documents every script written in the `DML/` folder with detailed
explanations. Use this as a personal reference and revision guide.

---

## What is DML?

DML stands for **Data Manipulation Language**. It is the category of SQL
commands used to manage the data inside tables. While DDL defines the
structure, DML fills it with data and keeps it updated.

| Command | Purpose |
|---------|---------|
| `INSERT` | Add new rows into a table |
| `UPDATE` | Modify existing rows |
| `DELETE` | Remove rows |

---

## INSERT

The `INSERT` command adds new rows into a table.
There are two ways to insert data — manually or by copying from another table.

---

### Method 1 — Manual Insert
**File:** `insert_data.sql`

Use this when you want to type the values directly into the query.

**Syntax:**
```sql
INSERT INTO table_name (column1, column2, column3, ...)
VALUES (value1, value2, value3, ...);
```

> **Rule:** The number of columns and values must always match.
> The order of values must match the order of columns exactly.

**Example — Insert rows into employees:**
```sql
INSERT INTO employees (id, first_name, last_name, hired_date, email, phone)
VALUES
    (1, 'Muhammad', 'Taha', NULL, 'example@gmail.com', '03159576354'),
    (2, 'Muhammad', 'Umer', NULL, 'example1@gmail.com', '03175842687');
```

You can insert multiple rows in one statement by separating each row
with a comma. This is more efficient than running separate `INSERT`
statements for each row.

---

### Inserting Without Specifying Column Names
**File:** `insert_data.sql`

If you know the exact order of all columns in the table you can skip
listing the column names:
```sql
INSERT INTO employees
VALUES (3, 'Muhammad', 'Taha', '2024-03-19', 'example@gmail.com', '03159996354');
```

> **Note:** This only works if you provide a value for every single column
> in the exact order they were defined in `CREATE TABLE`. If you are unsure
> of the column order always use the explicit column list — it is safer and
> more readable.

**Things to keep in mind:**
- Columns defined as `NOT NULL` must always receive a value
- Columns defined as `NULL` can receive `NULL` as a value
- Text values must be wrapped in single quotes `' '`
- Number values do not need quotes

---

### Method 2 — Insert by Copying from Another Table
**File:** `insert_data.sql`

Instead of typing values manually you can copy data directly from one
table into another using `INSERT` combined with `SELECT`.

**How it works:**
```
Step 1: SELECT filters and extracts data from the source table
Step 2: INSERT pipes that result directly into the target table
```

**Task:** Copy data from the `customers` table and insert into the `persons` table.

First look at both table structures to understand how columns map:

| customers | persons | Notes |
|-----------|---------|-------|
| `id` | `id` | Direct match |
| `first_name` | `person_name` | Same data, different column name |
| `country` | `birth_date` | No match — use `NULL` |
| *(none)* | `phone` | No match — use `'Unknown'` |
```sql
INSERT INTO persons (id, person_name, birth_date, phone)
SELECT
    id,
    first_name,
    NULL,
    'Unknown'
FROM customers;
```

**Result in persons table:**
| id | person_name | birth_date | phone   |
|----|-------------|------------|---------|
| 1  | Maria       | NULL       | Unknown |
| 2  | John        | NULL       | Unknown |
| 3  | Georg       | NULL       | Unknown |
| 4  | Martin      | NULL       | Unknown |
| 5  | Peter       | NULL       | Unknown |

**Breaking it down:**
- `id` and `first_name` are copied directly from `customers`
- `birth_date` has no matching column in `customers` so `NULL` is inserted
- `phone` is `NOT NULL` in `persons` so we cannot use `NULL` — instead
  `'Unknown'` is used as a placeholder string value
- The column names between the two tables don't need to match —
  what matters is the position and data type

---

### Key Takeaway

| Method | When to use |
|--------|-------------|
| Manual INSERT | Small amounts of data, testing, seeding |
| INSERT SELECT | Copying or migrating data between tables |
```sql
-- Manual
INSERT INTO table_name (col1, col2)
VALUES (val1, val2);

-- Copy from another table
INSERT INTO target_table (col1, col2)
SELECT col1, col2
FROM source_table
WHERE condition;
```

---

## UPDATE

The `UPDATE` command modifies existing rows in a table.

**Syntax:**
```sql
UPDATE table_name
    SET col1 = val1,
        col2 = val2
WHERE condition;
```

> **Critical Rule:** Always use `WHERE` with `UPDATE`. Without it every
> single row in the table will be updated — this is one of the most
> common and destructive mistakes in SQL.

---

### Best Practice Before Updating
**File:** `update_data.sql`

Before running any `UPDATE`, first run a `SELECT` with the same `WHERE`
condition to confirm you are targeting the correct rows:
```sql
-- Check first
SELECT * FROM customers WHERE id = 2;

-- Then update
UPDATE customers
    SET score = 0
WHERE id = 2;
```

This ensures you are not accidentally updating the wrong rows.

---

### Update a Single Column
**File:** `update_data.sql`

**Task:** Change the score of customer with id 2 to 0.
```sql
UPDATE customers
    SET score = 0
WHERE id = 2;
```

**Before:**
| id | first_name | country | score |
|----|------------|---------|-------|
| 2  | John       | USA     | 900   |

**After:**
| id | first_name | country | score |
|----|------------|---------|-------|
| 2  | John       | USA     | 0     |

Only the row where `id = 2` is affected. All other rows remain unchanged.

---

### Update Multiple Columns at Once
**File:** `update_data.sql`

**Task:** Change the score of customer with id 3 to 250 and update the country to Japan.
```sql
UPDATE customers
    SET score = 250,
        country = 'Japan'
WHERE id = 3;
```

**Before:**
| id | first_name | country | score |
|----|------------|---------|-------|
| 3  | Georg      | UK      | 750   |

**After:**
| id | first_name | country | score |
|----|------------|---------|-------|
| 3  | Georg      | Japan   | 250   |

Multiple columns are updated in one statement by separating each
assignment with a comma inside `SET`.

---

### Update Multiple Rows at Once
**File:** `update_data.sql`

**Task:** Update the country to Japan for all customers who are not already in Japan.
```sql
UPDATE customers
    SET country = 'Japan'
WHERE country != 'Japan';
```

**Before:**
| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Germany | 350   |
| 2  | John       | USA     | 0     |
| 3  | Georg      | Japan   | 250   |
| 4  | Martin     | Germany | 500   |
| 5  | Peter      | USA     | 0     |

**After:**
| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Japan   | 350   |
| 2  | John       | Japan   | 0     |
| 3  | Georg      | Japan   | 250   |
| 4  | Martin     | Japan   | 500   |
| 5  | Peter      | Japan   | 0     |

This is how you efficiently update hundreds of thousands of rows at once
using a condition — instead of updating each row individually.

---

### Key Takeaway

| Scenario | Approach |
|----------|----------|
| Update one row | `WHERE id = n` |
| Update multiple columns | Separate with comma inside `SET` |
| Update multiple rows | Use a condition that matches all target rows |
| Update all rows | Omit `WHERE` — but almost never do this intentionally |
```sql
UPDATE table_name
    SET col1 = val1,
        col2 = val2
WHERE condition;
```

Always `SELECT` before you `UPDATE` to confirm the right rows are targeted.

---

## DELETE

The `DELETE` command removes existing rows from a table.

**Syntax:**
```sql
DELETE FROM table_name
WHERE condition;
```

> **Critical Rule:** Always use `WHERE` with `DELETE`. Without it every
> single row in the table will be deleted — the table structure remains
> but all data inside it is gone.

---

### Delete Specific Rows
**File:** `delete_data.sql`

**Task:** Delete all customers with a score less than 250.
```sql
DELETE FROM customers
WHERE score < 250;
```

**Before:**
| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Japan   | 350   |
| 2  | John       | Japan   | 0     |
| 3  | Georg      | Japan   | 250   |
| 4  | Martin     | Japan   | 500   |
| 5  | Peter      | Japan   | 0     |

**After:**
| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Japan   | 350   |
| 3  | Georg      | Japan   | 250   |
| 4  | Martin     | Japan   | 500   |

John (0) and Peter (0) are deleted because their scores are less than 250.
Georg (250) is kept because `< 250` means strictly less than, not equal to.

---

### Delete All Rows from a Table
**File:** `delete_data.sql`
```sql
DELETE FROM persons;
```

This deletes every row from the `persons` table. The table itself still
exists with its structure and columns intact — only the data is removed.

---

### TRUNCATE — A Faster Alternative
**File:** `delete_data.sql`
```sql
TRUNCATE TABLE persons;
```

`TRUNCATE` does the same job as `DELETE FROM persons` — it removes all
rows from the table. However there is an important difference:

| | DELETE | TRUNCATE |
|-|--------|----------|
| Removes all rows | ✅ | ✅ |
| Can use WHERE | ✅ | ❌ |
| Logs each row deletion | ✅ | ❌ |
| Speed on large data | Slower | Faster |
| Can be rolled back | ✅ | ❌ (in most cases) |

`DELETE` logs every single row it removes which makes it slower on large
tables. `TRUNCATE` skips the row-by-row logging and removes all data at
once — making it significantly faster when you want to clear an entire table.

> **Rule of thumb:** Use `DELETE` when you need to remove specific rows
> using `WHERE`. Use `TRUNCATE` when you want to clear an entire table quickly.

---

### Key Takeaway
```sql
-- Delete specific rows
DELETE FROM table_name
WHERE condition;

-- Delete all rows (logged, slower)
DELETE FROM table_name;

-- Delete all rows (not logged, faster)
TRUNCATE TABLE table_name;
```

- `DELETE` without `WHERE` removes all rows — always double check
- `TRUNCATE` cannot be used with a `WHERE` condition
- Both `DELETE` and `TRUNCATE` keep the table structure intact
- `DROP TABLE` removes both the structure and the data entirely