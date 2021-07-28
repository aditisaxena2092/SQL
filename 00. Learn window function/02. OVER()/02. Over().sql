USE extras;
SELECT * FROM department;
SELECT * FROM employees;
SELECT * FROM purchase;

-- For each employee, find their first name, last name, salary and the sum of all salaries in the company.
SELECT
e.first_name,
e.last_name,
e.salary,
SUM(salary) OVER() AS Total_salary
FROM employees e;

-- For each employee in table employee, select first and last name, years_worked, average of years spent in the company by all
-- employees, and the difference between the years_worked and the average as difference 

SELECT
DISTINCT(concat(e.first_name," ",e.last_name)),
e.years_worked,
AVG(e.years_worked) OVER() AS Avg_Years_Worked,
ABS(AVG(e.years_worked) OVER() - e.years_worked) AS Difference
FROM employees e;

-- For all employees from department with department_id = 3, show their first_name, last_name, salary, 
-- the % of their salary to the SUM of all salaries in that department as percentage
SELECT
DISTINCT(concat(first_name," ",last_name)) AS Employee_Name,
years_worked,
salary,
SUM(salary) OVER() AS Total_Salary,
(salary/SUM(salary) OVER())*100 AS "%_of_Total"
FROM employees e
WHERE e.department_id=3;

-- For each employee that earns more than 4000, show their first_name, last_name, salary and the number of all employees who earn more than 4000
SELECT
DISTINCT(concat(first_name," ",last_name)) AS Employee_Name,
years_worked,
salary,
COUNT(e.id) OVER() AS Total_Employees
FROM employees e
WHERE e.salary>4000;


