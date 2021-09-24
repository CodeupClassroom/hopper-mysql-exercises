use employees;

-- we can concatenate columns with columns
-- we can also concatenate columns with other pieces of string
SELECT lower(concat(first_name, last_name, "@codeup.com")) as email_address
from employees
limit 10;

-- substring allows us to obtain part of a string
select concat(substr(first_name, 1, 1), last_name, emp_no) as username
from employees;

-- if a function returns a string, we can treat that function call like a string
select upper(lower(upper(lower("hello"))));

-- Let's say we want to rebrand HR in a report
-- this string replacement only happens on the results
-- the original data on the table is unchanged and safe.
select replace(dept_name, "Resources", "Solutions") from departments;


-- how many years has it been since each employee's original hire date and today?
select datediff(curdate(), hire_date) / 365
from employees;

-- unix time is the number of seconds since 1970-01-01
select unix_timestamp("1971-01-01");

-- we can get the day or month name of the week from a date (or string that matches the date format)
select dayname("1970-01-01");
select monthname("2022-01-01");

-- We can add our function outputs as new columns onto existing output
select *, dayname(birth_date) as "day_born"
from employees;

-- since max and min return numbers, we can do math on those numbers
select max(salary) - min(salary) as range_from_min_max from salaries;
select max(salary) - avg(salary) from salaries;
