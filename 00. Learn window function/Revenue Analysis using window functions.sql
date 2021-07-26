USE extras;
DROP TABLE salary;
CREATE TABLE Salary(
                  EMPID integer, 
                  NAME text, 
                  JOB text, 
                  SALARY  integer);

/* Sample data */
insert into Salary (EMPID, NAME, JOB, SALARY)
values
(201, 'ANIRUDDHA', 'ANALYST', 2100),
(212, 'LAKSHAY', 'DATA ENGINEER', 2700),
(209, 'SIDDHARTH', 'DATA ENGINEER', 3000),
(232, 'ABHIRAJ', 'DATA SCIENTIST', 3000),
(205, 'RAM', 'ANALYST', 2500),
(222, 'PRANAV', 'MANAGER', 4500),
(202, 'SUNIL', 'MANAGER', 4800),
(233, 'ABHISHEK', 'DATA SCIENTIST', 2800),
(244, 'PURVA', 'ANALYST', 2500),
(217, 'SHAROON', 'DATA SCIENTIST', 3000),
(216, 'PULKIT', 'DATA SCIENTIST', 3500),
(200, 'KUNAL', 'MANAGER', 5000),
(210, 'SHIPRA', 'ANALYST', 2800);

#1. Total Salary
SELECT *,
SUM(SALARY) OVER() AS Total_salary
FROM salary;

#2. Salary by Job profile
SELECT *,
SUM(SALARY) OVER() AS Total_salary,
SUM(SALARY) OVER(partition by JOB) AS Salary_by_job_profile
FROM salary;

#3. Salary by Job profile and rows arranged within partition
SELECT *,
SUM(SALARY) OVER() AS Total_salary,
SUM(SALARY) OVER(partition by JOB) AS Salary_by_job_profile,
SUM(SALARY) OVER(partition by JOB order by SALARY) AS Ordered_Salary
FROM salary;

#4. Row_number_
SELECT *,
row_number() OVER() AS "Row_number",
row_number() OVER(Partition by JOB order by SALARY desc) AS "Row_number_by_profile"
FROM salary;

#5. Rank and Dense Rank
SELECT *,
Rank() OVER(ORDER BY SALARY) AS "Rank",
Rank() OVER(PARTITION BY JOB ORDER BY SALARY ASC) AS "Rank_by",
Dense_Rank() OVER(PARTITION BY JOB ORDER BY SALARY ASC) AS "Dense_Rank_by"
FROM salary;

#6. Nth values
SELECT *,
NTH_VALUE(NAME,2) OVER( PARTITION BY JOB ORDER BY SALARY RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Nth_Value"
FROM SALARY;

#7. First values and Last Value
SELECT *,
FIRST_VALUE(NAME) OVER( PARTITION BY JOB ORDER BY SALARY RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "1st_Value",
LAST_VALUE(NAME) OVER( PARTITION BY JOB ORDER BY SALARY RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Last_Value"
FROM SALARY;


#8. Ntile
SELECT *,
NTILE(6) OVER(ORDER BY JOB) AS "Groups"
FROM SALARY;

#9. LEAD AND LAG
SELECT *,
LEAD(SALARY,1) OVER(PARTITION BY JOB ORDER BY SALARY) AS Next_Salary,
LAG(SALARY,1) OVER(PARTITION BY JOB ORDER BY SALARY) AS Next_Salary
FROM SALARY;
