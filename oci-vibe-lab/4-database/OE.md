# OE Schema Documentation

**Note:** No tables found in the OE schema. The OE user/schema does not exist in this database.

Available tables in the current ADMIN schema:
- BOOKINGS
- DBTOOLS$MCP_LOG (system table)
- DEPT  
- EMP
- MENU

## Sample data from relevant tables (for reference):

### DEPT (Departments table)
**Columns:** DEPTNO (NUMBER), DNAME (VARCHAR2), LOC (VARCHAR2)

**First 5 records:**
```
DEPTNO | DNAME      | LOC
10     | ACCOUNTING | NEW YORK
20     | RESEARCH   | ORACLE
30     | SALES      | CHICAGO
40     | OPERATIONS | BOSTON
```

### EMP (Employees table)
**Columns:** EMPNO (NUMBER), ENAME (VARCHAR2), JOB (VARCHAR2), MGR (NUMBER), HIREDATE (DATE), SAL (NUMBER), COMM (NUMBER), DEPTNO (NUMBER)

**First 5 records:**
```
EMPNO | ENAME | JOB      | MGR  | HIREDATE  | SAL  | COMM | DEPTNO
7369  | SMITH | CLERK    | 7902 | 17/12/80  | 800  |      | 20
7499  | ALLEN | SALESMAN | 7698 | 20/02/81  | 1600 | 300  | 30
7521  | WARD  | SALESMAN | 7698 | 22/02/81  | 1250 | 500  | 30
7566  | JONES | MANAGER  | 7839 | 02/04/81  | 2975 |      | 20
7654  | MARTIN| SALESMAN | 7698 | 28/09/81  | 1250 | 1400 | 30
```

### MENU (Restaurant Menu table)
**Columns:** ITEM_ID (NUMBER), NAME (VARCHAR2), DESCRIPTION (VARCHAR2), PRICE (NUMBER), ALLERGENS (VARCHAR2), CATEGORY (VARCHAR2)

**First 5 records:**
```
ITEM_ID | NAME           | DESCRIPTION          | PRICE | ALLERGENS     | CATEGORY
16      | Grilled Salmon | Fresh salmon...      | 24.99 | fish          | Main
17      | Caesar Salad   | Classic caesar...    | 14.99 | dairy, gluten | Starter
18      | Steak Frites   | Ribeye with fries    | 29.99 |               | Main
19      | Chocolate Cake | Rich chocolate...    | 9.99  | dairy, gluten | Dessert
20      | Veggie Stir Fry| Mixed vegetables...  | 16.99 | soy           | Main
```

### BOOKINGS (Restaurant Bookings table)
**Columns:** BOOKING_ID (NUMBER), BOOKING_DATE (DATE), SERVICE_TIME (VARCHAR2), GUEST_NAME (VARCHAR2), NUM_GUESTS (NUMBER), ALLERGIES (VARCHAR2), STATUS (VARCHAR2), CREATED_AT (TIMESTAMP)

**First 5 records:**
```
BOOKING_ID | BOOKING_DATE | SERVICE_TIME | GUEST_NAME | NUM_GUESTS | ALLERGIES       | STATUS   | CREATED_AT
10         | 05/05/26     | 18:00        | Joe Doe    | 2          | nuts            | CONFIRMED| 05/05/26 15:06:04...
11         | 05/05/26     | 19:30        | Joe Doe    | 4          |                 | CONFIRMED| 05/05/26 15:06:04...
12         | 06/05/26     | 18:00        | Joe Doe    | 3          | shellfish, dairy| CONFIRMED| 05/05/26 15:06:04...
4          | 04/05/26     | 18:00        | Joe Doe    | 2          | nuts            | CONFIRMED| 04/05/26 20:56:38...
5          | 04/05/26     | 19:30        | Joe Doe    | 4          |                 | CONFIRMED| 04/05/26 20:56:38...
```
