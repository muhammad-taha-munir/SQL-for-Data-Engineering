--Retrieve the Top 3 Customers with the Highest Scores

SELECT TOP 3
*
From customers
Order BY score DESC

-- Retrieve the Lowest 2 Customers based on the score

SELECT TOP 2 *
From customers
Order BY score ASC

--Get the Two most recent orders

SELECT TOP 2 *
FROM orders
ORDER BY order_date DESC