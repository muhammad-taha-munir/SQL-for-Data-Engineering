-- INSERT into tables using DML two ways to insert the data see the explanation.md if you dont understand any thing

INSERT INTO employees (id, first_name, last_name, hired_date, email, phone)
VALUES
	(1, 'Muhammad', 'Taha', NULL, 'example@gmail.com', 03159576354),
	(2, 'Muhammad', 'Umer', NULL, 'example1@gmail.com', 03175842687)

SELECT * FROM employees


INSERT INTO employees
VALUES
	(3, 'Muhammad', 'Taha', '2024-03-19', 'example@gmail.com', 03159996354)


INSERT INTO persons(id, person_name, birth_date, phone)
SELECT
id,
first_name,
NULL,
'Unknown'
FROM customers

SELECT * FROM persons