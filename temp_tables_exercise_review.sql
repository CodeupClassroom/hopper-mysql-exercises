-- General Algorithm for any problem:
-- “If you can't solve a problem, then there is an easier problem you can solve: find it.” - Polya

-- Create a temporary table called employees_with_departments 
-- that contains first_name, last_name, and dept_name 
-- for employees currently with that department. Be absolutely sure to create this table on your own database
-- Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
-- Update the table so that full name column contains the correct data
-- Remove the first_name and last_name columns from the table.
-- What is another way you could have ended up with this same table?

-- Step 1: blow off whatever I can afford to blow off, first. (temp table)
-- Step 2: Plan out in text or comments what tables you need to talk to
-- What db? employees
-- What tables? employees table for names, departments table dept_name, dept_emp to join
-- step 3: start small w/ one table, run your query to prove 
-- step 3.5: figure out the columns later 
-- "reduce cognitive overhead"
use employees;

create temporary table ryan.employees_with_departments AS (
	select first_name, last_name, dept_name
	from employees
	join dept_emp using(emp_no)
	join departments using(dept_no)
	where to_date > curdate()
);

use ryan;
select *
from employees_with_departments;

-- describe employees.employees;

-- add the full name column to our temp_table
alter table employees_with_departments add full_name VARCHAR(31);

select * from employees_with_departments;

-- to change values in a column, use update:
update employees_with_departments
set full_name = concat(first_name, " ", last_name);

select * from employees_with_departments;



-- alter table employees_with_departments drop column first_name;
-- alter table employees_with_departments drop column last_name;
alter table employees_with_departments drop column first_name, drop column last_name;

use ryan;
-- drop table employees_with_departments; 

-- show tables;
use employees;
create temporary table ryan.employees_with_departments AS (
	select concat(first_name, ' ', last_name) as full_name, dept_name
	from employees
	join dept_emp using(emp_no)
	join departments using(dept_no)
	where to_date > curdate()
);

select * from ryan.employees_with_departments;
describe ryan.employees_with_departments;


-- Create a temporary table based on the payment table from the sakila database.
-- Write the SQL necessary to transform the amount column 
-- such that it is stored as an integer representing the number of cents of the payment. 
-- For example, 1.99 should become 199.

use sakila;

create temporary table ryan.payments as (
	select * from payment
);

-- double check it worked
select * from ryan.payments;

-- check the data types w/ describe
describe ryan.payments;

-- time to add a new column
alter table ryan.payments add column cents INT UNSIGNED;

-- set the values for that new column
update ryan.payments
set cents = ryan.payments.amount * 100;

-- double check your work ran
select * from ryan.payments;


-- Find out how the current average pay in each department 
-- compares to the overall, historical average pay. 
-- In order to make the comparison easier, you should use the Z-score for salaries. 
-- In terms of salary, what is the best department right now to work for? 
-- The worst?

-- how can we simplify?
-- blow off what we can, where we can (reducing cognitive overhead)
-- zscore = (x - avg(x)) / stddev(x)

-- step 1: find historic average pay
-- average historic salary is 63811
use employees;
select round(avg(salary)) from salaries;

-- step 2: find historic standard deviation of salaries
-- historic standard deviation is 16905
select round(stddev(salary)) from salaries;

-- step 3: Find current average pay in each department
-- if you see "each" or "for each" in a problem statement for SQL
-- You're probably going to be grouping by the noun specified by "for each"
-- I need departments for dept_name
-- I need salaries to get $$
-- I need something that associates salary w/ department (emp_no to dept_no) (dept_emp)
select dept_name, round(avg(salary)) as current_dept_avg_salary
from departments
join dept_emp using(dept_no)
join salaries using(emp_no)
where salaries.to_date > curdate()
and dept_emp.to_date > curdate()
group by dept_name;

create temporary table ryan.salaries_by_dept as (
	select dept_name, round(avg(salary)) as current_dept_avg_salary
	from departments
	join dept_emp using(dept_no)
	join salaries using(emp_no)
	where salaries.to_date > curdate()
	and dept_emp.to_date > curdate()
	group by dept_name
);

select * from ryan.salaries_by_dept;

use ryan;

-- add our historic avg(salary) column
-- add our historic std(salary) column
-- add our zscore column

alter table salaries_by_dept add column company_avg_salary FLOAT(10, 2);
alter table salaries_by_dept add column company_std_salary FLOAT(10, 2);
alter table salaries_by_dept add column zscore FLOAT(10, 2);

select * from ryan.salaries_by_dept;

-- let's rely on our previously determined avg(salary) and std(salary)
update salaries_by_dept 
set company_avg_salary = (select avg(salary) from employees.salaries);

select * from ryan.salaries_by_dept;

update salaries_by_dept
set company_std_salary = (select stddev(salary) from employees.salaries);

-- double check our work
select * from ryan.salaries_by_dept;

-- now we can calculate the zscore!
update salaries_by_dept
set zscore = (current_dept_avg_salary - company_avg_salary) / company_std_salary;

 -- double check our work
select * from ryan.salaries_by_dept
order by zscore desc;

