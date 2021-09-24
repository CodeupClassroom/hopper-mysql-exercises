-- 1. Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.

USE employees;

-- 2. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. (709 observations)

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;

-- a. In your comments, answer: What was the first and last name in the first row of the results? (10397	1955-11-11	Irena	Reutenauer	M	1993-05-21)

-- b. What was the first and last name of the last person in the table? (497788	1958-11-25	Vidya	Simmen	M	1988-03-25)

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name DESC, emp_no DESC;

-- 3. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name.  (709 observations)

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;

-- a. In your comments, answer: What was the first and last name in the first row of the results? (46986	1964-10-15	Irena	Acton	M	1992-07-11)

-- b. What was the first and last name of the last person in the table? (97971	1956-07-14	Vidya	Zweizig	M	1986-12-22)

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name DESC, last_name DESC;

-- 4. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. (709 observations)

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;

-- a. In your comments, answer: What was the first and last name in the first row of the results? (46986	1964-10-15	Irena	Acton	M	1992-07-11)

-- b. What was the first and last name of the last person in the table? (479435	1959-07-10	Maya	Zyda	M	1987-08-23)

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name DESC, first_name DESC;


-- 5. Write a query to find all employees whose last name starts AND ends with 'E'. Sort the results by their employee number. (899 rows)

SELECT * 
FROM employees
WHERE last_name LIKE 'e%e'
order by emp_no ASC;

-- Ramzi	Erde	
-- Tadahiro	Erde DESC

-- 6. Write a query to to find all employees whose last name starts AND ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. (899 observations)

SELECT * 
FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY hire_date;

-- Teiji	Eldridge (newest)

SELECT * 
FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY birth_date;

-- Sergi	Erde (oldest by hire_date)
-- Piyush	Erbe (by birth_date)



-- 7. Find all employees hired in the 90s AND born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. 
-- 362 observations

SELECT *
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%-12-25'
ORDER BY birth_date, hire_date DESC;

-- 33936	1952-12-25	Khun	Bernini	M	1999-08-31


-- b. and the name of the youngest emmployee who was hired first.
SELECT *
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%-12-25'
ORDER BY birth_date DESC, hire_date ASC;

-- 412745	1964-12-25	Douadi	Pettis	M	1990-05-04


-- LIMIT Exercises
-- List the first 10 distinct last name sorted in descending order.

SELECT DISTINCT last_name
FROM employees
ORDER by last_name DESC
LIMIT 10;

/* Zykh
Zyda
Zwicker
Zweizig
Zumaque
Zultner
Zucker
Zuberek
Zschoche
Zongker */

-- Find all previous or current employees hired in the 90s and born on Christmas. Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. Write a comment in your code that lists the five names of the employees returned.

SELECT  first_name, last_name, emp_no
FROM employees
WHERE hire_date LIKE '199%' 
AND birth_date LIKE '%-12-25'
ORDER BY hire_date
LIMIT 5;

/* Alselm	Cappello	243297
Utz	Mandell	34335
Bouchung	Schreiter	400710
Baocai	Kushner	465730
Petter	Stroustrup	490744 */


/* 4. Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results.

LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number? */


SELECT  first_name, last_name, emp_no
FROM employees
WHERE hire_date LIKE '199%' 
AND birth_date LIKE '%-12-25'
ORDER BY hire_date
LIMIT 5 OFFSET 45;

/* Pranay	Narwekar	463558
Marjo	Farrow	444269
Ennio	Karcich	291662
Dines	Lubachevsky	413687
Ipke	Fontan	416525 */

-- LIMIT = 5
/* Page 1, 1-5, offset 0
Page 2, 6-10, offset 5
Page 3, 11-15, offset 10
..
..
Page n, Offset = (page -1) * LIMIT */


-- Another approach
use employees;

SELECT first_name, last_name, emp_no
FROM employees
WHERE hire_date LIKE '199%' 
AND birth_date LIKE '%-12-25'
ORDER BY hire_date
LIMIT 5 OFFSET 0; # page 1, showing 5 results

SELECT first_name, last_name, emp_no
FROM employees
WHERE hire_date LIKE '199%' 
AND birth_date LIKE '%-12-25'
ORDER BY hire_date
LIMIT 5 OFFSET 5; # page 2, showing 5 results

-- # page 1 = limit 5 offset 0
-- # page 2 = limit 5 offset 5
-- # page 3 = limit 5 offset 10
-- # page 4 = limit 5 offset 15
-- # page 5 = limit 5 offset 20
-- # page n = limit 5 offset (n - 1)*5

SELECT first_name, last_name, emp_no
FROM employees
WHERE hire_date LIKE '199%' 
AND birth_date LIKE '%-12-25'
ORDER BY hire_date
LIMIT 5 OFFSET 45; # page 10 of the result  