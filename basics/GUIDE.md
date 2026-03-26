# Basics Guide

## Setting Up the Practice Database

The script for the basic practice database is available in the `databases/` folder
on GitHub. To set it up:

1. Open **SQL Server Management Studio (SSMS)**
2. Click **New Query**
3. Paste the entire script into the query window
4. Click **Execute**
5. The database named `MyDatabase` will be created

---

## Selecting a Database

Before writing any queries you need to select which database you want to work with.

**Option 1 — Using the dropdown:**
In the ribbon at the top of SSMS there is a dropdown list showing all available
databases. Simply select `MyDatabase` from there.

**Option 2 — Using a query:**
```sql
USE MyDatabase;
```
Execute this and `MyDatabase` will be selected as your active database.

---

## File Naming Convention

All query files in this folder are saved with the `.sql` extension.
The naming format used is:
```
action_tablename.sql
```

Examples:
- `select_customers.sql` — retrieves all customer data
- `select_orders.sql` — retrieves all order data

---

## First Query — Retrieving All Customer Data

The `customers` table comes from `MyDatabase`. To retrieve all records:
```sql
SELECT * FROM customers;
```

The table name reference is essential — SQL needs to know exactly which
table to pull data from.
