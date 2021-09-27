
-- Subqueries lesson
-- https://docs.google.com/presentation/d/1ymLGKr_eXR-u6oSqChXlRmMbAcpEOFkMLT91Eb56gSQ/edit?usp=sharing


/* A subquery is a SELECT statement within another statement.
A subquery can return a scalar (a single value), a single row, a single column, or a table (one or more rows of one or more columns). These are called scalar, column, row, and table subqueries. */

# scalar example:


-- what is current average salary?
select avg(salary)
from salaries
where to_date > now();
 
 -- find all employees whose current salary > average salary
 
 select emp_no, salary, first_name, last_name, gender
 from salaries
 JOIN employees using(emp_no)
 where salary > 
 	(
	 select avg(salary)
	from salaries
	where to_date > now()
 	);
 

-- Column Subqueries Return a Single Column
--  find all the department managers names and birth dates

# get emp_no for dept managers

select emp_no
from dept_manager
where to_date > now();
 
 
 select first_name, last_name, gender
 from employees
 where emp_no IN 
 	(
 	select emp_no
	from dept_manager
	where to_date > now()
 	);


-- Table Subqueries Return an Entire Table

-- find all employees with first name starting with 'geor. Then join with salary table and list first_name, last_name and salary


select *
from employees
where first_name LIKE 'geor%';


select first_name, last_name, salary
FROM 
	(
	select *
	from employees
	where first_name LIKE 'geor%'
	) g
JOIN salaries using(emp_no);



select count(*) from salaries
where to_date > now()
 and salary > (select max(salary) - std(salary) from salaries where to_date > now());
 
 select count(*)
 from salaries
 where to_date > now()





 





