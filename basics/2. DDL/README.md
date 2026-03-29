# DDL — Explanation Guide

This file documents every script written in the `DDL/` folder with detailed
explanations. Use this as a personal reference and revision guide.

---

## What is DDL?

DDL stands for **Data Definition Language**. It is the category of SQL commands
used to define and manage the structure of a database. A database cannot store
anything useful without tables — DDL is how you create and manage those tables.

Unlike query commands such as `SELECT`, DDL commands do not return any data.
Instead you get a confirmation message like:
```
Commands completed successfully.
```

Or an error message if something went wrong. DDL changes the **structure** of
your database, not the data inside it.

---

## CREATE

The `CREATE` command is used to create new tables in a database.

---

### Create a Persons Table
**File:** `create_table.sql`

**Task:** Create a new table called `persons` with columns:
`id`, `person_name`, `birth_date` and `phone`
```sql
CREATE TABLE persons (
    id          INT          NOT NULL,
    person_name VARCHAR(50)  NOT NULL,
    birth_date  DATE         NULL,
    phone       VARCHAR(11)  NOT NULL,
    CONSTRAINT pk_persons PRIMARY KEY (id)
);
```

**Breaking it down column by column:**

| Column | Data Type | Constraint | Meaning |
|--------|-----------|------------|---------|
| `id` | `INT` | `NOT NULL` | A whole number, must always have a value |
| `person_name` | `VARCHAR(50)` | `NOT NULL` | Text up to 50 characters, required |
| `birth_date` | `DATE` | `NULL` | A date value, optional — can be left empty |
| `phone` | `VARCHAR(11)` | `NOT NULL` | Text up to 11 characters, required |

**Key concepts:**

- **`NOT NULL`** — the column must always have a value. You cannot insert
  a row without providing this field.
- **`NULL`** — the column is optional. A row can be inserted without
  providing a value for this field.
- **`VARCHAR(n)`** — stores text up to `n` characters. Only uses as much
  space as needed — `VARCHAR(50)` storing "John" uses 4 characters not 50.
- **`INT`** — stores whole numbers only. No decimals.
- **`DATE`** — stores date values in `YYYY-MM-DD` format.
- **`CONSTRAINT pk_persons PRIMARY KEY (id)`** — sets `id` as the
  **Primary Key** of this table. A primary key uniquely identifies each
  row — no two rows can have the same `id` and it can never be `NULL`.

---

### Key Takeaway
```sql
CREATE TABLE table_name (
    column_name   DATA_TYPE   CONSTRAINT,
    column_name   DATA_TYPE   CONSTRAINT,
    CONSTRAINT pk_table_name PRIMARY KEY (column_name)
);
```

- DDL commands change database **structure**, not data
- You will never see rows returned after running a DDL command
- Always define a **Primary Key** — it uniquely identifies each row
- Use `NOT NULL` for fields that are required and `NULL` for optional fields

---

## ALTER

The `ALTER` command is used to modify the structure of an existing table.
This includes adding new columns, changing data types, or removing columns.

---

### Add a New Column
**File:** `alter_table.sql`
```sql
ALTER TABLE persons
ADD email VARCHAR(50) NOT NULL;
```

This adds a new `email` column to the `persons` table.

> **Important:** New columns are always appended at the end of the table.
> If you need a column at the beginning or middle of the table and it already
> contains data, you will have to drop the entire table and recreate it with
> the column in the correct position.

---

### Remove a Column
**File:** `alter_table.sql`
```sql
ALTER TABLE persons
DROP COLUMN phone;
```

This permanently removes the `phone` column from the `persons` table.

> **Warning:** Dropping a column deletes all data stored in that column
> permanently. There is no undo. Always make sure you no longer need the
> data before dropping a column.

---

### Key Takeaway

| Operation | Syntax |
|-----------|--------|
| Add a column | `ALTER TABLE table_name ADD column_name DATA_TYPE CONSTRAINT` |
| Remove a column | `ALTER TABLE table_name DROP COLUMN column_name` |

- `ALTER` changes the structure of an existing table
- Adding a column always places it at the end of the table
- Dropping a column is permanent — all data in that column is lost

---

## DROP

The `DROP` command is used to completely remove a table from the database.
This deletes both the table structure and all the data inside it permanently.

---

### Remove a Table
**File:** `drop_table.sql`

**Task:** Remove the table `persons` from the database.
```sql
DROP TABLE persons;
```

This removes the `persons` table entirely from `MyDatabase`. After running
this command the table no longer exists — you cannot query it or recover it.

> **Warning:** `DROP TABLE` is one of the most destructive commands in SQL.
> It deletes everything — the structure, the columns, and all the data inside.
> There is no undo. Always double check before running this command.

---

### Key Takeaway

| Command | What it deletes |
|---------|-----------------|
| `DROP COLUMN` | A single column and its data |
| `DROP TABLE` | The entire table, all columns and all data |

- `DROP` is permanent — there is no undo or recycle bin
- Always confirm you are connected to the correct database before dropping
- In a real work environment dropping a table is rarely done without a backup