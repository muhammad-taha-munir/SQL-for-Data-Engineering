--Retrieve all customers and sort the results by the country and then by the highest score

SELECT *
FROM customers
ORDER BY
	country ASC,
	score DESC
--This kind of sorting make sense if you have repitions in your data
