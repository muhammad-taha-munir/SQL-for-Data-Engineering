--		DDL Practice Questions

-- SECTION 1: CREATE

/*
Task 1. Create a new table called `employees` with the following columns:
- `id` — whole number, required, primary key
- `first_name` — text up to 50 characters, required
- `last_name` — text up to 50 characters, required
- `hire_date` — date, optional
- `salary` — whole number, required
*/

CREATE TABLE employees(
	id INT NOT NULL,
	first_name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	hired_date DATE NULL,
	salary INT NOT NULL,
	CONSTRAINT pk_employees PRIMARY KEY (id)
)

/*
Task 2. Create a new table called `departments` with the following columns:
- `department_id` — whole number, required, primary key
- `department_name` — text up to 100 characters, required
- `location` — text up to 100 characters, optional
*/

CREATE TABLE departments (
	department_id INT NOT NULL,
	department_name VARCHAR(100) NOT NULL,
	location VARCHAR(100) NULL 
	CONSTRAINT pk_departments PRIMARY KEY (department_id)
)

-- SECTION 2: ALTER

/*
Task 3. Add a new column called `email` to the `employees` table.
The column should store text up to 100 characters and is optional.
*/

ALTER TABLE employees
ADD email VARCHAR(100) NULL

/*
Task 4. Add a new column called `phone` to the `employees` table.
The column should store text up to 11 characters and is required.
*/

ALTER TABLE employees
ADD phone VARCHAR(11) NOT NULL


-- Task 5. Remove the `salary` column from the `employees` table.

ALTER TABLE employees
DROP COLUMN salary

--SECTION 3: DROP

-- Task 6. Remove the `departments` table from the database entirely.

DROP TABLE departments

-- SECTION 4: MIXED

/*
Task 7. Do the following in order:
1. Create a table called `projects` with columns `project_id` (INT, NOT NULL, primary key), `project_name` (VARCHAR 200, NOT NULL) and `start_date` (DATE, NULL)
2. Add a new column called `budget` (INT, NOT NULL) to the `projects` table
3. Drop the `projects` table
*/

CREATE TABLE projects(
	project_id INT NOT NULL,
	project_name VARCHAR(200) NOT NULL,
	start_date DATE NULL,
	CONSTRAINT pk_projects PRIMARY KEY (project_id)
)

ALTER TABLE projects
ADD budget INT NOT NULL

DROP TABLE projects
