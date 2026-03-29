# DML — Practice Test

**Database:** Basic Database (`MyDatabase`)
**Tables available:** `customers`, `orders`, `persons`, `employees`

Try to write the queries yourself before checking `solutions.sql`.

---

## Section 1 — INSERT

**Q1.** Insert the following two rows into the `persons` table:
- id: 10, person_name: 'Ali Hassan', birth_date: '1995-06-15', phone: '03001234567'
- id: 11, person_name: 'Sara Khan', birth_date: NULL, phone: '03119876543'

**Q2.** Insert a new row into the `employees` table without specifying
column names (use the exact column order from DDL):
- id: 5, first_name: 'Ahmed', last_name: 'Raza', hire_date: '2023-01-10', email: 'ahmed@gmail.com', phone: '03211112233'

**Q3.** Copy all customers from the `customers` table into the `persons` table
where the customer score is greater than 400. For `birth_date` use `NULL`
and for `phone` use `'Unknown'`.

---

## Section 2 — UPDATE

**Q4.** Update the score of the customer with id 1 to 999.

**Q5.** Update the country to `'USA'` and score to `0` for the customer
with id 4.

**Q6.** Update the phone to `'00000000000'` for all employees
where phone is currently `'03211112233'`.

---

## Section 3 — DELETE

**Q7.** Delete the customer with id 3 from the `customers` table.

**Q8.** Delete all orders where sales are less than or equal to 15.

**Q9.** Delete all rows from the `persons` table using `DELETE`.

**Q10.** Clear all rows from the `employees` table using `TRUNCATE`.

---

## Section 4 — Mixed

**Q11.** Do the following in order:
1. Insert a new customer into `customers`: id: 6, first_name: 'Zara', country: 'Germany', score: 600
2. Update her score to 750
3. Delete her from the table