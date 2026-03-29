# SQL Basics — Practice Test

**Database:** Basic Database (same as used throughout the basics folder)
**Tables:** `customers`, `orders`

Try to write the queries yourself before checking `solutions.sql`.

---

## Section 1 — SELECT

**Q1.** Retrieve all columns from the `orders` table.

**Q2.** Retrieve only the `first_name` and `country` columns from the `customers` table.

---

## Section 2 — WHERE

**Q3.** Retrieve all customers who are from the USA.

**Q4.** Retrieve all orders where sales are greater than 15.

**Q5.** Retrieve all customers where the score is not equal to 350.

---

## Section 3 — ORDER BY

**Q6.** Retrieve all customers sorted by `first_name` alphabetically (A to Z).

**Q7.** Retrieve all orders sorted by `sales` from highest to lowest.

**Q8.** Retrieve all customers sorted by `country` A to Z and then by `score` lowest to highest.

---

## Section 4 — TOP

**Q9.** Retrieve the top 2 most expensive orders by sales.

**Q10.** Retrieve the top 1 customer with the lowest score.

---

## Section 5 — DISTINCT

**Q11.** Retrieve a unique list of all countries from the customers table.

---

## Section 6 — GROUP BY & Aggregations

**Q12.** Find the total sales for all orders.

**Q13.** Find the average score of all customers.

**Q14.** Find the total number of customers per country.

**Q15.** Find the total sales per customer using the orders table.

---

## Section 7 — HAVING

**Q16.** Find countries where the total score is greater than 800.

**Q17.** Find countries where the total number of customers is more than 1.

---

## Section 8 — Static Values

**Q18.** Retrieve `id` and `first_name` from customers and add a static
column called `status` with the value `Active` for all rows.

---

## Section 9 — Mixed (Combine Multiple Concepts)

**Q19.** Retrieve the top 3 customers from Germany or USA, sorted by score highest first.

**Q20.** Find the average score per country, excluding customers with a score of 0,
only show countries where the average score is above 400, sorted by average score highest first.
