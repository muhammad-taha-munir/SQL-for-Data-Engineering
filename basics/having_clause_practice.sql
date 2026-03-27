/*
Next we have is the having clause in SQL just like in previous example we know that
Group by we are using a column named country but with aggregation we will be using the 
HAVING clause here we will demonstrated with and example also i will give a number based
on which part will run first in a query

4. SELECT
	country
	SUM(score)
1. FROM customers
2. GROUP BY country
3. HAVING SUM(score)>800

*/
SELECT
	country,
	SUM(score) AS Score_Greater_then_800
FROM customers
GROUP BY country
HAVING SUM(score)>800

/*
Another scenario if you want to filter the data twice maybe before the aggregation
you can use the WHERE clause before the HAVING clause here we will explain by example
*/
SELECT
	country,
	SUM(score)
FROM customers
WHERE score > 400
GROUP BY country
HAVING SUM(score)>800

SELECT * FROM customers