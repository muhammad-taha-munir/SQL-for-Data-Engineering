# Setting Up Practice Databases

There are two ways to set up a database for practice in Microsoft SQL Server.

---

## Method 1: Using Scripts

SQL scripts for creating databases are available in the `databases/` folder.
Simply open the script in SSMS and execute it to create the database.

---

## Method 2: Restoring from a Backup File (.bak)

### Step 1 — Download the Database
Download a `.bak` backup file of your chosen database.
For this example, AdventureWorks was used — download it from:
https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure

### Step 2 — Move the .bak File
Cut and paste the downloaded `.bak` file into the SQL Server backup folder.
The default directory is inside your SQL Server installation path, for example:
```
T:\SQL Express Edition\Software\MSSQL17.SQLEXPRESS\MSSQL\Backup
```

> Note: The path may differ depending on where you installed SQL Server
> and which drive you chose during installation.

### Step 3 — Restore in SSMS
1. Open **SQL Server Management Studio (SSMS)**
2. In the Object Explorer, right-click **Databases**
3. Click **Restore Database**
4. Under Source, select **Device** and click the **...** button
5. In the new window, click **Add**
6. The Backup folder will open automatically — select your `.bak` file
7. Click **OK** → **OK** again
8. The database will be restored and ready to use

---