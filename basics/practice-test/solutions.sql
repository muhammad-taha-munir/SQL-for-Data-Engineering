--Task 1. Retrieve all columns from the orders table.

SELECT * FROM orders

--Task 2. Retrieve only the first_name and country columns from the customers table.

SELECT
first_name,
country
FROM customers

--Task 3. Retrieve all customers who are from the USA.

SELECT *
FROM customers
WHERE country = 'USA'

--Task 4. Retrieve all orders where sales are greater than 15.

SELECT *
FROM orders
WHERE sales > 15

--Task 5. Retrieve all customers where the score is not equal to 350.

SELECT *
FROM customers
WHERE score != 350

--Task 6. Retrieve all customers sorted by first_name alphabetically (A to Z).

SELECT *
FROM customers
ORDER BY first_name ASC

--Task 7. Retrieve all orders sorted by sales from highest to lowest.

SELECT *
FROM orders
ORDER BY sales DESC

--Task 8. Retrieve all customers sorted by country A to Z and then by score lowest to highest.

SELECT *
FROM customers
ORDER BY country ASC, score ASC

--Task 9. Retrieve the top 2 most expensive orders by sales.

SELECT TOP 2 *
FROM orders
ORDER BY sales DESC

--Task 10. Retrieve the top 1 customer with the lowest score.

SELECT TOP 1 *
FROM customers
ORDER BY score ASC

--Task 11. Retrieve a unique list of all countries from the customers table.

SELECT DISTINCT country
FROM customers

--Task 12. Find the total sales for all orders.

SELECT
SUM(sales) AS total_sales
FROM orders

--Task 13. Find the average score of all customers.

SELECT
AVG(score) AS Average_Score
FROM customers

--Task 14. Find the total number of customers per country.

SELECT
country,
COUNT(id)
FROM customers
GROUP BY country

--Task 15. Find the total sales per customer using the orders table.

SELECT
customer_id,
COUNT(sales) AS total_sales
FROM orders
GROUP BY customer_id

--Task 16. Find countries where the total score is greater than 800.

SELECT
country,
SUM(score) AS total_score
FROM customers
GROUP BY country
HAVING SUM(score) > 800

--Task 17. Find countries where the total number of customers is more than 1.

SELECT
country,
COUNT(id) AS total_number_of_customers
FROM customers
GROUP BY country
HAVING COUNT(id) > 1

/*Task 18.  Retrieve id and first_name from customers and add a static
column called status with the value Active for all rows.*/

SELECT
id,
first_name,
'Active' AS status
FROM customers

--Task 19. Retrieve the top 3 customers from Germany or USA, sorted by score highest first.

SELECT TOP 3
id,
first_name,
country,
score
FROM customers
WHERE country = 'Germany' OR country = 'USA'
ORDER BY score DESC

/*Task 20. Find the average score per country, excluding customers with a score of 0,
only show countries where the average score is above 400, sorted by average score highest first.*/

SELECT 
country,
AVG(score) AS Average_Score
FROM customers
WHERE score > 0
GROUP BY country
HAVING AVG(score) > 400
ORDER BY AVG(score) DESC