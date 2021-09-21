# Exercise 1
# Write a query to to find all employees whose last name starts and ends with 'E'. Use concat() to combine their first and last name together as a single column named full_name.

# 704 rows
select concat(first_name, " ", last_name) as full_name from employees
where first_name like 'E%e';

# Exercise 2
# Convert the names produced in your last query to all uppercase.
# 704 rows
select upper(concat(first_name, " ", last_name)) as full_name from employees
where first_name like 'E%e';

# Exercise 3
# Find all employees hired in the 90s and born on Christmas. Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()),

select first_name, last_name, datediff(now(), hire_date) as "days_with_company"
from employees
where hire_date like '199%'
and birth_date like '%-12-25';

# Exercise 4
# Find the smallest and largest current salary from the salaries table.
select min(salary), max(salary) from salaries where to_date > curdate();

# Exercise 5
# Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like:

select lower(concat(
    substr(first_name, 1, 1), # first initial of first name
    substr(last_name, 1, 4), # first 4 of last name
		 "_",
		 substr(hire_date, 6, 2), # month
		 substr(hire_date, 3, 2) # 2 yr
)) as username,first_name, last_name, birth_date
from employees;