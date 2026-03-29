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