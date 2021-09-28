-- write a query that shows all current employees, their department, and the department manager
-- Looks like:

-- Employee Name, Department, Manager
-- Jane Janeway, Development, Amy
-- Bob Bobberson, Development, Amy 
-- Pat Patterson, Sales, Gerald

-- What tables do I need to talk to?
-- Need employees table to get the employee name and their emp_no
-- Need the dept_emp table to associate each employee w/ their department
-- Need the departments table to get the dept_name
-- now that I have a dept_no from departments table, I need the manager's info?
-- Ok, I know dept_manager connects dept_no to emp_no of a manager
-- Ok, but now how do I get first_name, last_name of that manager based on their emp_no

use employees;

select employees.emp_no, concat(employees.first_name, " ", employees.last_name) as employee_name, 
dept_name, dept_no, dept_manager.emp_no,
concat(managers.first_name, " ", managers.last_name) as manager_name
from employees
join dept_emp using(emp_no)
join departments using(dept_no)
join dept_manager using(dept_no)
join employees as managers on managers.emp_no = dept_manager.emp_no
where dept_emp.to_date > curdate()
and dept_manager.to_date > curdate();

