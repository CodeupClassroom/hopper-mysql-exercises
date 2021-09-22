-- 1. Create a new file named group_by_exercises.sql

-- 2. In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file. (7 unique titles)

USE employees;

SELECT DISTINCT
	title
FROM titles;

-- 3. Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.

SELECT
	last_name
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY last_name;

/*
Eldridge
Erbe
Erde
Erie
Etalle
*/

-- 4. Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'. (846 unique combinations)

SELECT
	first_name,
	last_name
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY first_name, last_name;

-- 5. Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code. (3 unique last names)

SELECT
	last_name
FROM employees
WHERE last_name LIKE '%q%' 
	AND last_name NOT LIKE '%qu%'
GROUP BY last_name;

/*
Chleq
Lindqvist
Qiwen
*/

-- 6. Add a COUNT() to your results (the query above) and use ORDER BY to make it easier to find employees whose unusual name is shared with others.

SELECT
	last_name,
	COUNT(last_name) AS count_of_names
FROM employees
WHERE last_name LIKE '%q%' 
	AND last_name NOT LIKE '%qu%'
GROUP BY last_name
ORDER BY last_name;

/*
Chleq	    189
Lindqvist	190
Qiwen	    168
*/

-- 7. Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.

SELECT
	gender,
	COUNT(first_name) AS number_of_employees,
	first_name
FROM employees
WHERE first_name IN('Irena', 'Vidya', 'Maya')
GROUP BY gender, first_name
ORDER BY first_name;

/*
M	144	Irena
F	97	Irena
M	146	Maya
F	90	Maya
F	81	Vidya
M	151	Vidya
*/

-- 8. Using your query that generates a username for all of the employees, generate a count of employees for each unique username. Are there any duplicate usernames? (285_872 usernames returned with counts)

SELECT 
	LOWER(
			CONCAT(
				SUBSTR(first_name, 1, 1),
				SUBSTR(last_name, 1, 4),
				'_',
				SUBSTR(birth_date, 6, 2),
				SUBSTR(birth_date, 3, 2)
				)
			) AS username,
	COUNT(*) AS number_of_duplicates
FROM employees
GROUP BY username
ORDER BY number_of_duplicates DESC;


-- BONUS: How many duplicate usernames are there?

-- step-by-step

SELECT 
		LOWER(
				CONCAT(
					SUBSTR(first_name, 1, 1),
					SUBSTR(last_name, 1, 4),
					'_',
					SUBSTR(birth_date, 6, 2),
					SUBSTR(birth_date, 3, 2)
					)
				) AS username,
		COUNT(*) AS number_of_duplicates
FROM employees
GROUP BY username
HAVING number_of_duplicates > 1;

-- Now return the number of unique duplicate usernames AND the total of duplicate usernames.

SELECT
	COUNT(t.number_of_duplicates) AS unique_duplicate_usernames,
	SUM(t.number_of_duplicates) AS number_of_duplicate_usernames
FROM (SELECT 
		LOWER(
				CONCAT(
					SUBSTR(first_name, 1, 1),
					SUBSTR(last_name, 1, 4),
					'_',
					SUBSTR(birth_date, 6, 2),
					SUBSTR(birth_date, 3, 2)
					)
				) AS username,
	COUNT(*) AS number_of_duplicates
	FROM employees
	GROUP BY username
	HAVING number_of_duplicates > 1) as t;
