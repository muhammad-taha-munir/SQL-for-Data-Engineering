-- SECTION 1: INSERT

SELECT * FROM persons

/*
Task 1. Insert the following two rows into the `persons` table:
- id: 10, person_name: 'Ali Hassan', birth_date: '1995-06-15', phone: '03001234567'
- id: 11, person_name: 'Sara Khan', birth_date: NULL, phone: '03119876543'
*/

INSERT INTO persons (id, person_name, birth_date, phone)
VALUES 
	(10, 'Ali Hassan', '1995-06-15', '03001234567'),
	(11, 'Sara Khan', NULL, '03119876543')

/*
Task 2. Insert a new row into the `employees` table without specifying
column names (use the exact column order from DDL):
- id: 5, first_name: 'Ahmed', last_name: 'Raza', hire_date: '2023-01-10', email: 'ahmed@gmail.com', phone: '03211112233'
*/

SELECT * FROM employees

INSERT INTO employees
VALUES
	(5, 'Ahmed', 'Raza', '2023-01-10', 'ahmed@gmail.com', '03211112233')

/*
Task 3. Copy all customers from the `customers` table into the `persons` table
where the customer score is greater than 400. For `birth_date` use `NULL`
and for `phone` use `'Unknown'`.
*/
INSERT INTO persons (id, person_name, birth_date, phone)
SELECT
id,
first_name,
NULL,
'Unknown'
FROM customers
WHERE score > 400

--SECTION 2: UPDATE

-- Task 4. Update the score of the customer with id 1 to 999.

UPDATE customers
	SET score = 999
WHERE id = 1

-- Task 5. Update the country to `'USA'` and score to `0` for the customer with id 4.

UPDATE customers
	SET score = 0,
		country = 'USA'
WHERE id = 4

/*
Task 6.  Update the phone to `'00000000000'` for all employees
where phone is currently `'03211112233'`.
*/

UPDATE employees
	SET phone = '00000000000'
WHERE phone = '03211112233'

--SECTION 3. DELETE

--Task 7. Delete the customer with id 3 from the `customers` table.

DELETE FROM customers
WHERE id = 3

SELECT * FROM customers

--Task 8.  Delete all orders where sales are less than or equal to 15.

DELETE FROM orders
WHERE sales <= 15

--Task 9. Delete all rows from the `persons` table using `DELETE`.

DELETE FROM persons

--Task 10. Clear all rows from the `employees` table using `TRUNCATE`.

TRUNCATE TABLE employees

--SECTION 4: Mixed

/*
Task 11. Do the following in order:
1. Insert a new customer into `customers`: id: 6, first_name: 'Zara', country: 'Germany', score: 600
2. Update her score to 750
3. Delete her from the table
*/

INSERT INTO customers(id, first_name, country, score)
VALUES
	(6, 'Zara', 'Germany', 600)

UPDATE customers
	SET score = 750
WHERE id = 6

DELETE FROM customers
WHERE id =6

