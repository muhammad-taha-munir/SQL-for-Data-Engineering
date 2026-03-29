# DDL — Practice Test

**Database:** Basic Database (`MyDatabase`)

Try to write the queries yourself before checking the solutions.

---

## Section 1 — CREATE

**Q1.** Create a new table called `employees` with the following columns:
- `id` — whole number, required, primary key
- `first_name` — text up to 50 characters, required
- `last_name` — text up to 50 characters, required
- `hire_date` — date, optional
- `salary` — whole number, required

**Q2.** Create a new table called `departments` with the following columns:
- `department_id` — whole number, required, primary key
- `department_name` — text up to 100 characters, required
- `location` — text up to 100 characters, optional

---

## Section 2 — ALTER

**Q3.** Add a new column called `email` to the `employees` table.
The column should store text up to 100 characters and is optional.

**Q4.** Add a new column called `phone` to the `employees` table.
The column should store text up to 11 characters and is required.

**Q5.** Remove the `salary` column from the `employees` table.

---

## Section 3 — DROP

**Q6.** Remove the `departments` table from the database entirely.

---

## Section 4 — Mixed

**Q7.** Do the following in order:
1. Create a table called `projects` with columns `project_id` (INT, NOT NULL, primary key), `project_name` (VARCHAR 200, NOT NULL) and `start_date` (DATE, NULL)
2. Add a new column called `budget` (INT, NOT NULL) to the `projects` table
3. Drop the `projects` table
