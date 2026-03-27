-- Find the Average score for each country  
--considering only customers with a score not equal to 0

SELECT * FROM customers

SELECT
	country,
	AVG(score)
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430
