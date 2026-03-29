# DDL — Practice Test Solutions

**Database:** Basic Database (`MyDatabase`)

---

## Section 1 — CREATE

### Q1. Create the employees table.
```sql
CREATE TABLE employees (
    id          INT          NOT NULL,
    first_name  VARCHAR(50)  NOT NULL,
    last_name   VARCHAR(50)  NOT NULL,
    hire_date   DATE         NULL,
    salary      INT          NOT NULL,
    CONSTRAINT pk_employees PRIMARY KEY (id)
);
```

| Column | Data Type | Constraint | Reason |
|--------|-----------|------------|--------|
| `id` | INT | NOT NULL, PRIMARY KEY | Uniquely identifies each employee |
| `first_name` | VARCHAR(50) | NOT NULL | Every employee must have a first name |
| `last_name` | VARCHAR(50) | NOT NULL | Every employee must have a last name |
| `hire_date` | DATE | NULL | Hire date may not always be available |
| `salary` | INT | NOT NULL | Every employee must have a salary defined |

---

### Q2. Create the departments table.
```sql
CREATE TABLE departments (
    department_id   INT           NOT NULL,
    department_name VARCHAR(100)  NOT NULL,
    location        VARCHAR(100)  NULL,
    CONSTRAINT pk_departments PRIMARY KEY (department_id)
);
```

> **Note:** Always add a `PRIMARY KEY` constraint when a column is
> specified as a primary key. Without it the column is just `NOT NULL`
> but has no uniqueness enforcement — two rows could have the same
> `department_id` which defeats the purpose.

---

## Section 2 — ALTER

### Q3. Add an optional email column to employees.
```sql
ALTER TABLE employees
ADD email VARCHAR(100) NULL;
```

`NULL` makes the column optional — existing rows will have `NULL` as
the default value for `email` since no data exists for them yet.

---

### Q4. Add a required phone column to employees.
```sql
ALTER TABLE employees
ADD phone VARCHAR(11) NOT NULL;
```

> **Note:** Adding a `NOT NULL` column to a table that already has rows
> can cause an error in SQL Server because existing rows have no value
> for the new column. In practice you would either add it as `NULL` first,
> populate the data, then alter it to `NOT NULL` — or ensure the table
> is empty before adding a required column.

---

### Q5. Remove the salary column from employees.
```sql
ALTER TABLE employees
DROP COLUMN salary;
```

The `salary` column and all its data is permanently removed from the
`employees` table. This cannot be undone.

---

## Section 3 — DROP

### Q6. Remove the departments table entirely.
```sql
DROP TABLE departments;
```

The entire `departments` table — its structure and all data — is
permanently deleted from the database.

---

## Section 4 — Mixed

### Q7. Create, alter, then drop the projects table.
```sql
-- Step 1: Create the table
CREATE TABLE projects (
    project_id   INT          NOT NULL,
    project_name VARCHAR(200) NOT NULL,
    start_date   DATE         NULL,
    CONSTRAINT pk_projects PRIMARY KEY (project_id)
);

-- Step 2: Add budget column
ALTER TABLE projects
ADD budget INT NOT NULL;

-- Step 3: Drop the table
DROP TABLE projects;
```

This task combined all three DDL commands in sequence — the correct
order matters here. You cannot `ALTER` a table before it is created,
and you cannot `DROP` a table that does not exist.

> **Common mistake:** Missing the comma before `CONSTRAINT` inside
> `CREATE TABLE`. Every line except the last one must end with a comma.

---

## DDL Summary

| Command | Purpose | Reversible |
|---------|---------|------------|
| `CREATE TABLE` | Creates a new table | Yes — drop it |
| `ALTER TABLE ADD` | Adds a new column | Yes — drop the column |
| `ALTER TABLE DROP COLUMN` | Removes a column | No |
| `DROP TABLE` | Removes entire table | No |