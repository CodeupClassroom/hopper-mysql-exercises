/* Case Statements Lesson Notes/Code */
USE employees;

-- Simple format example
SELECT dept_name,
	CASE dept_name
	WHEN 'research' THEN 'Development'
	WHEN 'marketing' THEN 'Sales'
	ELSE dept_name
	END AS dept_group
FROM departments;

-- Flexible format example
SELECT dept_name,
	CASE
		WHEN dept_name IN ('research', 'development') THEN 'R&D'
		WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing'
		WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
		ELSE dept_name
		END AS dept_group
FROM departments;

-- IF() function example
SELECT dept_name,
       IF(dept_name = 'Research', True, False) AS is_research
FROM employees.departments;

-- Pivot table development
-- Here, I'm building up my columns and values before I group by departments and use an aggregate function to get a count of values in each column.
SELECT
    dept_name,
    CASE WHEN title = 'Senior Engineer' THEN title ELSE NULL END AS 'Senior Engineer',
    CASE WHEN title = 'Staff' THEN title ELSE NULL END AS 'Staff',
    CASE WHEN title = 'Engineer' THEN title ELSE NULL END AS 'Engineer',
    CASE WHEN title = 'Senior Staff' THEN title ELSE NULL END AS 'Senior Staff',
    CASE WHEN title = 'Assistant Engineer' THEN title ELSE NULL END AS 'Assistant Engineer',
    CASE WHEN title = 'Technique Leader' THEN title ELSE NULL END AS 'Technique Leader',
    CASE WHEN title = 'Manager' THEN title ELSE NULL END AS 'Manager'
FROM departments
JOIN dept_emp USING(dept_no)
JOIN titles USING(emp_no);

-- Next, I add my GROUP BY clause and COUNT function to get a count of all employees
-- In this query, I filter in my JOINs for current employees who currently hold each title.
SELECT
    dept_name,
    COUNT(CASE WHEN title = 'Senior Engineer' THEN title ELSE NULL END) AS 'Senior Engineer',
    COUNT(CASE WHEN title = 'Staff' THEN title ELSE NULL END) AS 'Staff',
    COUNT(CASE WHEN title = 'Engineer' THEN title ELSE NULL END) AS 'Engineer',
    COUNT(CASE WHEN title = 'Senior Staff' THEN title ELSE NULL END) AS 'Senior Staff',
    COUNT(CASE WHEN title = 'Assistant Engineer' THEN title ELSE NULL END) AS 'Assistant Engineer',
    COUNT(CASE WHEN title = 'Technique Leader' THEN title ELSE NULL END) AS 'Technique Leader',
    COUNT(CASE WHEN title = 'Manager' THEN title ELSE NULL END) AS 'Manager'
FROM departments
JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
    AND dept_emp.to_date > CURDATE()
JOIN titles ON dept_emp.emp_no = titles.emp_no
    AND titles.to_date > CURDATE()
GROUP BY dept_name
ORDER BY dept_name;

-- Example of multiple solutions to achieve the same output
SELECT dept_name,
	CASE dept_name
		WHEN 'Research' THEN 1
		ELSE 0
		END AS is_research
FROM departments;

SELECT dept_name,
	dept_name = 'Research' AS is_research
FROM departments;

SELECT dept_name,
	IF(dept_name = 'Research', True, False) AS is_research
FROM departments;

SELECT dept_name,
	CASE
		WHEN dept_name = 'Research' THEN True
		ELSE False
		END AS cool_guy_PJ
FROM departments;