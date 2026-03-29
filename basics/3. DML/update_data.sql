/*
UPDATE Syntax

UPDATE table_name
	SET col1 = val1,
		col2 = val2
WHERE <condition>

Always use Where if you dont it will update all rows unintentionally
*/

-- Change the score of customer 2 to 0

UPDATE customers
	SET score = 0
WHERE id = 2

-- Before running the update query best practice is to check with SELECT like this

SELECT * FROM customers WHERE id = 2

-- Change the score of customer with id 3 to 250 and update the country to Japan

UPDATE customers
	SET score = 250,
		country = 'Japan'
WHERE id = 3

-- What if we have hundered of thousands of rows of data we cant update the country for each of then invidually 

UPDATE customers
	SET country = 'Japan'
WHERE country != 'Japan'