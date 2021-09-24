
SELECT* 
FROM users;

SELECT* 
FROM roles;

SELECT* 
FROM users
JOIN roles
ON users.role_id = roles.id;

SELECT* 
FROM users
left JOIN roles
ON users.role_id = roles.id;


SELECT* 
FROM users
RIGHT JOIN roles
ON users.role_id = roles.id;


SELECT roles.name, count(*)
FROM roles
LEFT JOIN users
ON roles.id = users.role_id
GROUP BY roles.name;


-- Employees Exercises

-- 2 write a query that shows each department along with the name of the current manager for that department.

SELECT concat(first_name, ' ', last_name), dept_name, gender
FROM employees as e
JOIN dept_manager as dm using(emp_no)
JOIN departments as d using(dept_no)
WHERE dm.to_date > now()
order by dept_name;


-- 3. Find the name of all departments currently managed by women.
SELECT concat(first_name, ' ', last_name), dept_name, gender
FROM employees as e
JOIN dept_manager as dm using(emp_no)
JOIN departments as d using(dept_no)
WHERE dm.to_date > now() and gender = 'F'
order by dept_name;



-- 4. Find the current titles of employees currently working in the Customer Service department.

select title, count(*)
FROM titles as t
JOIN dept_emp de using(emp_no)
JOIN departments d using(dept_no)
WHERE t.to_date > now() 
AND de.to_date > now()
AND dept_name LIKE 'Customer%'
group by title;



-- 5. Find the current salary of all current managers.

select dept_name, salary, first_name, last_name 
FROM salaries as s
JOIN dept_manager dm using(emp_no)
JOIN departments d using(dept_no)
JOIN employees e using(emp_no)
WHERE s.to_date > now()
AND dm.to_date > now()
order by dept_name;



-- 6. Find the number of current employees in each department.

SELECT dept_name, count(*)
FROM dept_emp as de
JOIN departments d using(dept_no)
Where de.to_date > now()
group by dept_name
order by dept_name;



-- 7. Which department has the highest average salary? Hint: Use current not historic information.

SELECT dept_name, avg(salary)
FROM salaries s
JOIN dept_emp de using(emp_no)
JOIN departments d using(dept_no)
WHERE s.to_date > now()
AND de.to_date > now()
group by dept_name
order by avg(salary) DESC
Limit 1;



-- 8. Who is the highest paid employee in the Marketing department?

SELECT first_name, last_name, salary
FROM salaries as s
JOIN dept_emp de using(emp_no)
JOIN departments d using(dept_no)
JOIN employees e using(emp_no)
WHERE s.to_date > now()
AND de.to_date > now()
AND dept_name LIKE 'Market%'
order by salary DESC
Limit 1;



-- 9 Which current department manager has the highest salary?

select first_name, last_name, salary, dept_name
from salaries as s
JOIN dept_manager dm using(emp_no)
JOIN employees e using(emp_no)
JOIN departments d using(dept_no)
WHERE s.to_date > now()
AND dm.to_date > now()
order by salary DESC
limit 1;


-- Bonus Find the names of all current employees, their department name, and their current manager's name.

select concat(managers.first_name,managers.last_name) as 'manager_name', concat(employees.first_name, ' ', employees.last_name) as employees_name, d.dept_name
from employees as managers  #aliasing here allows us to "self join" the employees table.
join dept_manager dm using(emp_no)
join departments d using(dept_no)
join dept_emp de using(dept_no)
join employees on de.emp_no = employees.emp_no  #(self join)
where de.to_date > now()
and dm.to_date > now();


-- Bonus Who is the highest paid employee within each department.
-- I used a sub-query to solve this

select salary, dept_name, first_name, last_name
from employees e
join salaries sa using(emp_no)
join dept_emp using(emp_no)
join departments using(dept_no)
WHERE salary IN 
    (select max(salary)
    from salaries s
    join employees e using(emp_no)
    join dept_emp de using(emp_no)
    join departments using(dept_no)
    where s.to_date > now()
    and de.to_date > now()
    group by dept_name);
