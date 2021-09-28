
# What?
- Temporary Tables

## So What?
Securtiy and Data Integrity rationale:
	- we don't need all the keys to all the castles all the time.. b/c human error
	- common pattern, set SELECT permissions on stuff you need to see
	- but only enable more "admin" access like delete or update on a sandbox db.
Accessibility and ease of access:
	- If you notice you keep on making the same query with 3 joins and 2 where clauses 

## Now What?
- If you're reading from the salaries table on the employees db, then recommend using syntax like employees.salaries or more generally db_name.table_name

- If you're writing data (making tables), talk to the database(s) you can write to. 
If you username is hopper_1234 then your db name is hopper_1234.table_name

```sql
USE employees;

CREATE TEMPORARY TABLE hopper_1234.employees_with_departments AS
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100;
```