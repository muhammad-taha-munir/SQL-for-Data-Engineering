-- DELETE query is used to delete already existing rows

/*
DELETE syntax

DELETE FROM table_name
WHERE <condition>

*/

--Delete all customers with score less than 250

DELETE FROM customers
WHERE score < 250

-- Without a WHERE all of the rows are updated

SELECT * FROM customers

-- DELETE all data from table persons

DELETE FROM persons

-- So when we delete any data from any table using the DELETE command it is being logged so it can be a bit slow i would recommend you use TRUNCATE

-- Like this:

TRUNCATE TABLE persons