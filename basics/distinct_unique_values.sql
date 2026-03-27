--Return unique list of all countries
SELECT * FROM customers

SELECT DISTINCT
country
FROM customers
-- Distinct is used when you want unique values from a table here in this we did unique values from customers table we went further and only wanted unique values from customers table and and the country column
-- BAD habbits with DISTINCT don't use unless its necessary, it can slow down your query
-- ONLY use DISTINCT if you see duplication or repitition in your data.
-- Example
SELECT DISTINCT id
FROM customers
--Since id is always unique its a waste of resource to use DISTINCT here