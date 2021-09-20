/* Where
Order By 
Limit */


-- Select all employees whose gender is 'M'. (returns 179973 records)

SELECT first_name, last_name, gender, emp_no
FROM employees
WHERE gender = 'M';

-- select all employees whose hire date is '1986-01-01'. (returns 80 records)

SELECT *
FROM employees
WHERE hire_date = '1986-01-01';


-- ############ WHERE with LIKE Keyword and % Wildcard ###########

-- return all records where first names contains letter combination of 'sus' (returns 1697 records)

SELECT *
FROM employees
WHERE first_name LIKE '%sus%';

-- return all records where first names begins with letter combination of 'sus' (returns 1406 records)

SELECT *
FROM employees
WHERE first_name LIKE 'SUS%';

-- return all records where first ends with letter combination of 'sa' (returns 1430 records)

SELECT *
FROM employees
WHERE first_name LIKE '%sa';


-- return only unique first names contains letter combination of 'sus' (returns 7 records)

SELECT DISTINCT first_name
FROM employees
WHERE first_name LIKE '%sus%';

-- Use WHERE with BETWEEN


-- return emp number, first name and last name of employees with emp_no between 10026 and 10082 (returns 57 records)

SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no >= 10026 AND emp_no <=10082;

-- Same query with Between
SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no BETWEEN 10026 AND 10082;

-- We can use WHERE with IN to query only very specific sets of values. 

--  Return records for employees with first name 'Satosi', 'Satish', 'Saniya', 'Sumant' (719 records)

SELECT * 
FROM employees
WHERE first_name IN ('Satosi', 'Satish', 'Saniya', 'Sumant');



-- ######################### WHERE with AND & OR Operators ########################

-- Return records where last name is 'Herber' OR 'Baek'

SELECT * 
FROM employees
WHERE last_name = 'Herber'
OR last_name = 'Baek';


-- Return records where last name is 'Herber' and gender is 'F'

SELECT * 
FROM employees
WHERE last_name = 'Herber'
AND gender = 'F';

-- Return records where last name is 'Herber' or 'Baek' and the employee number is less than 20000 (Returns 14 records)

SELECT *
FROM employees
WHERE last_name IN ('Herber', 'Baek')
AND emp_no < 20000;


-- Return records where last name is either 'Herber' or 'Baek' OR first name is 'Shridhar' and the employee number is less than 20000 

SELECT *
FROM employees
WHERE (last_name = 'Herber' OR last_name = 'Baek'
OR first_name = 'Shridhar') AND emp_no < 20000;

-- Parenthesis > NOT > AND > OR
-- - PEDMAS, BODMAS



-- Using 'is null'
USE curriculum_logs;


-- Select all records from logs where cohort_id is NULL (52893 records)
SELECT * 
FROM logs
WHERE cohort_id IS NULL;

-- Select all records from logs where cohort_id is not NULL and user_id = 40 (579 records)
SELECT *
FROM logs
WHERE cohort_id IS NOT NULL
AND user_id = 40;

-- Using NOT
-- select all records where first name  start with 'eb' but does not end in 'e'

SELECT * 
FROM employees
WHERE first_name LIKE 'eb%'
AND NOT first_name LIKE '%e';

SELECT hire_date, year(hire_date), month(hire_date), day(hire_date), weekday(hire_date)
FROM employees;

SELECT * from employees
where month(birth_date) = 12 AND day(birth_date) = 25;

-- order by

-- Return first_name and last_names for all employees ordered by last_name (Ascending order is default)
SELECT first_name, last_name
FROM employees
WHERE gender = 'F'
ORDER BY last_name;

-- Return first_name and last_names for all employees ordered by last_name in descending order


-- Return first_name and last_names for all employees ordered by last_name and then first_name (Chaining)
SELECT first_name, last_name
FROM employees
WHERE gender = 'F'
ORDER BY last_name ASC, first_name DESC;

-- #########LIMIT and OFFSET#######
-- limits the number of results returned to a number you specify.

-- SELECT columns FROM table LIMIT count [OFFSET count];


-- Return 10 records for employees whose first name starts with 'M'

SELECT * FROM employees
WHERE gender = 'M'
ORDER BY last_name
LIMIT 5;

-- Adding an OFFSET tells MySQL which row to start retreiving data. E.g. offset 5 means skip first 5 rows.

SELECT * FROM employees
WHERE gender = 'M'
ORDER BY last_name
LIMIT 5 OFFSET 10  ;

-- Same as above
SELECT * FROM employees
WHERE gender = 'M'
ORDER BY last_name
LIMIT 10,5;


-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

SELECT *
FROM employees
WHERE first_name in ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;
-- Irena Reutenauer
-- Last: Vidya simmen

-- 3. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name.  (709 observations)

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name DESC, last_name DESC;
