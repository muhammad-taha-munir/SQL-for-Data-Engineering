/*
We can also add values or i should say static values here is an examples of it

*/
SELECT 123 AS static_number
-- If we talk about how we can use this with our tables here is an example of that as well
SELECT 
id,
first_name,
'New Customer' AS Customer_Type
FROM customers

-- The new column and the data in the new column comes from the query and not from the database