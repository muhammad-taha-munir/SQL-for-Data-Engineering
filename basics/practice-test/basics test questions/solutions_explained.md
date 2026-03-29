# SQL Basics — Practice Test Solutions

**Database:** Basic Database
**Tables:** `customers`, `orders`

---

## Section 1 — SELECT

### Q1. Retrieve all columns from the orders table.
```sql
SELECT * FROM orders;
```

**Result:**
| order_id | customer_id | order_date | sales |
|----------|-------------|------------|-------|
| 1001     | 1           | 2021-01-11 | 35    |
| 1002     | 2           | 2021-04-05 | 15    |
| 1003     | 3           | 2021-06-18 | 20    |
| 1004     | 6           | 2021-08-31 | 10    |

`*` returns every column from the table as is.

---

### Q2. Retrieve only the first_name and country columns from the customers table.
```sql
SELECT
    first_name,
    country
FROM customers;
```

**Result:**
| first_name | country |
|------------|---------|
| Maria      | Germany |
| John       | USA     |
| Georg      | UK      |
| Martin     | Germany |
| Peter      | USA     |

Only the two specified columns are returned. All other columns are ignored.

---

## Section 2 — WHERE

### Q3. Retrieve all customers who are from the USA.
```sql
SELECT *
FROM customers
WHERE country = 'USA';
```

**Result:**
| id | first_name | country | score |
|----|------------|---------|-------|
| 2  | John       | USA     | 900   |
| 5  | Peter      | USA     | 0     |

Text values in `WHERE` conditions must always be wrapped in single quotes.

---

### Q4. Retrieve all orders where sales are greater than 15.
```sql
SELECT *
FROM orders
WHERE sales > 15;
```

**Result:**
| order_id | customer_id | order_date | sales |
|----------|-------------|------------|-------|
| 1001     | 1           | 2021-01-11 | 35    |
| 1003     | 3           | 2021-06-18 | 20    |

Orders with sales of 15 and 10 are excluded. `>` means strictly greater than,
not equal to.

---

### Q5. Retrieve all customers where the score is not equal to 350.
```sql
SELECT *
FROM customers
WHERE score != 350;
```

**Result:**
| id | first_name | country | score |
|----|------------|---------|-------|
| 2  | John       | USA     | 900   |
| 3  | Georg      | UK      | 750   |
| 4  | Martin     | Germany | 500   |
| 5  | Peter      | USA     | 0     |

Maria (score = 350) is excluded. `!=` means not equal to.

---

## Section 3 — ORDER BY

### Q6. Retrieve all customers sorted by first_name alphabetically (A to Z).
```sql
SELECT *
FROM customers
ORDER BY first_name ASC;
```

**Result:**
| id | first_name | country | score |
|----|------------|---------|-------|
| 3  | Georg      | UK      | 750   |
| 2  | John       | USA     | 900   |
| 1  | Maria      | Germany | 350   |
| 4  | Martin     | Germany | 500   |
| 5  | Peter      | USA     | 0     |

`ASC` sorts alphabetically A to Z for text columns.

---

### Q7. Retrieve all orders sorted by sales from highest to lowest.
```sql
SELECT *
FROM orders
ORDER BY sales DESC;
```

**Result:**
| order_id | customer_id | order_date | sales |
|----------|-------------|------------|-------|
| 1001     | 1           | 2021-01-11 | 35    |
| 1003     | 3           | 2021-06-18 | 20    |
| 1002     | 2           | 2021-04-05 | 15    |
| 1004     | 6           | 2021-08-31 | 10    |

`DESC` sorts highest value first.

---

### Q8. Retrieve all customers sorted by country A to Z and then by score lowest to highest.
```sql
SELECT *
FROM customers
ORDER BY country ASC, score ASC;
```

**Result:**
| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Germany | 350   |
| 4  | Martin     | Germany | 500   |
| 3  | Georg      | UK      | 750   |
| 5  | Peter      | USA     | 0     |
| 2  | John       | USA     | 900   |

Two sort conditions are applied. Country sorts first alphabetically, then
within each country score sorts lowest to highest.

---

## Section 4 — TOP

### Q9. Retrieve the top 2 most expensive orders by sales.
```sql
SELECT TOP 2 *
FROM orders
ORDER BY sales DESC;
```

**Result:**
| order_id | customer_id | order_date | sales |
|----------|-------------|------------|-------|
| 1001     | 1           | 2021-01-11 | 35    |
| 1003     | 3           | 2021-06-18 | 20    |

`ORDER BY sales DESC` sorts highest first, `TOP 2` then takes only the
first two rows from that sorted result.

---

### Q10. Retrieve the top 1 customer with the lowest score.
```sql
SELECT TOP 1 *
FROM customers
ORDER BY score ASC;
```

**Result:**
| id | first_name | country | score |
|----|------------|---------|-------|
| 5  | Peter      | USA     | 0     |

`ORDER BY score ASC` puts the lowest score first, `TOP 1` returns only
that single row.

---

## Section 5 — DISTINCT

### Q11. Retrieve a unique list of all countries from the customers table.
```sql
SELECT DISTINCT country
FROM customers;
```

**Result:**
| country |
|---------|
| Germany |
| USA     |
| UK      |

Without `DISTINCT` Germany and USA would appear twice each. `DISTINCT`
collapses repeated values into one row per unique value.

---

## Section 6 — GROUP BY & Aggregations

### Q12. Find the total sales for all orders.
```sql
SELECT
    SUM(sales) AS total_sales
FROM orders;
```

**Result:**
| total_sales |
|-------------|
| 80          |

No `GROUP BY` is needed here because we want one single total across
all orders, not a total per group. (35 + 15 + 20 + 10 = 80)

---

### Q13. Find the average score of all customers.
```sql
SELECT
    AVG(score) AS average_score
FROM customers;
```

**Result:**
| average_score |
|---------------|
| 500           |

`AVG` adds all scores and divides by the number of rows.
(350 + 900 + 750 + 500 + 0 = 2500 ÷ 5 = 500)

---

### Q14. Find the total number of customers per country.
```sql
SELECT
    country,
    COUNT(id)
FROM customers
GROUP BY country;
```

**Result:**
| country | COUNT(id) |
|---------|-----------|
| Germany | 2         |
| UK      | 1         |
| USA     | 2         |

`COUNT(id)` counts how many rows exist in each country group.
Note: adding `AS total_customers` as an alias would make the output cleaner.

---

### Q15. Find the total sales per customer using the orders table.
```sql
SELECT
    customer_id,
    COUNT(sales) AS total_sales
FROM orders
GROUP BY customer_id;
```

**Result:**
| customer_id | total_sales |
|-------------|-------------|
| 1           | 1           |
| 2           | 1           |
| 3           | 1           |
| 6           | 1           |

Note: `COUNT(sales)` counts the number of orders per customer, not the
sum of sales. To get the actual total sales amount `SUM(sales)` would
be more appropriate here. Both are valid depending on what you need —
count of orders vs total revenue.

---

## Section 7 — HAVING

### Q16. Find countries where the total score is greater than 800.
```sql
SELECT
    country,
    SUM(score) AS total_score
FROM customers
GROUP BY country
HAVING SUM(score) > 800;
```

**Result:**
| country | total_score |
|---------|-------------|
| Germany | 850         |
| USA     | 900         |

UK (750) is excluded because its total score does not exceed 800.
`HAVING` filters after grouping — `WHERE` cannot filter aggregated results.

---

### Q17. Find countries where the total number of customers is more than 1.
```sql
SELECT
    country,
    COUNT(id) AS total_number_of_customers
FROM customers
GROUP BY country
HAVING COUNT(id) > 1;
```

**Result:**
| country | total_number_of_customers |
|---------|---------------------------|
| Germany | 2                         |
| USA     | 2                         |

UK is excluded because it only has 1 customer. This query finds countries
that have more than one customer — useful for identifying your biggest markets.

---

## Section 8 — Static Values

### Q18. Retrieve id and first_name from customers and add a static column called status with the value Active for all rows.
```sql
SELECT
    id,
    first_name,
    'Active' AS status
FROM customers;
```

**Result:**
| id | first_name | status |
|----|------------|--------|
| 1  | Maria      | Active |
| 2  | John       | Active |
| 3  | Georg      | Active |
| 4  | Martin     | Active |
| 5  | Peter      | Active |

`'Active'` is a static text value hardcoded in the query. It repeats for
every row. The `status` column does not exist in the database — it exists
only in this query output.

---

## Section 9 — Mixed

### Q19. Retrieve the top 3 customers from Germany or USA, sorted by score highest first.
```sql
SELECT TOP 3
    id,
    first_name,
    country,
    score
FROM customers
WHERE country = 'Germany' OR country = 'USA'
ORDER BY score DESC;
```

**Result:**
| id | first_name | country | score |
|----|------------|---------|-------|
| 2  | John       | USA     | 900   |
| 4  | Martin     | Germany | 500   |
| 1  | Maria      | Germany | 350   |

`WHERE` filters to Germany and USA only (4 customers), `ORDER BY score DESC`
sorts highest first, then `TOP 3` takes the first three from that result.
Georg (UK) is excluded by the `WHERE` clause entirely.

---

### Q20. Find the average score per country, excluding customers with a score of 0, only show countries where the average score is above 400, sorted by average score highest first.
```sql
SELECT
    country,
    AVG(score) AS average_score
FROM customers
WHERE score > 0
GROUP BY country
HAVING AVG(score) > 400
ORDER BY AVG(score) DESC;
```

**Result:**
| country | average_score |
|---------|---------------|
| USA     | 900           |
| UK      | 750           |
| Germany | 425           |

Step by step:
1. `WHERE score > 0` — excludes Peter (0)
2. `GROUP BY country` — groups remaining 4 customers by country
3. `HAVING AVG(score) > 400` — all three countries pass (Germany = 425)
4. `ORDER BY AVG(score) DESC` — sorted highest average first

This question combined every major concept from the basics section in
a single query — WHERE, GROUP BY, HAVING, and ORDER BY together.