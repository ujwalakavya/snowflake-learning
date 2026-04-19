use MYDB;
use MYDB.MYSCHEMA;

-- Let's create a view called "it_employees" that only includes the employees from the IT department:
CREATE OR REPLACE VIEW it_employees AS
SELECT id, name, salary
FROM employees
WHERE department = 'IT';

-- Select data from the it_employees view
SELECT * FROM it_employees;

-------------------------------------------------

-- Let's create a view called "hr_employees" that only includes the employees from the HR department:
CREATE OR REPLACE SECURE VIEW hr_employees AS
SELECT id, name, salary
FROM employees
WHERE department = 'HR';

-- Select data from the hr_employees view
SELECT * FROM hr_employees;


-------------------------------------------------

-- Create a view that aggregates the salaries by department.
CREATE OR REPLACE VIEW employee_salaries AS
SELECT
    department,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department;

-- Select data from the employee_salaries view
SELECT * FROM employee_salaries;

-------------------------------------------------

-- Create a materialized view that aggregates the salaries by department.
CREATE OR REPLACE MATERIALIZED VIEW materialized_employee_salaries AS
SELECT
    department,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department;

-- Select data from the materialized_employee_salaries view
SELECT * FROM materialized_employee_salaries;

SHOW VIEWS;

