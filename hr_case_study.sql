# Active Employees
# Objective: Identify all currently active employees to understand current workforce size.
select 
employee_ID,concat(first_name," ",last_name)as full_name,
department_id,job_id from employees_hr 
where employment_status ='active';

# Q2. High Minimum-Salary Roles
# Objective: Find job roles with a minimum salary above 60,000 
# to understand senior-role compensation bands.

select * from jobs_hr
where minimum_salary >'60000' 
order by minimum_salary desc
limit 10;

# Q3. Recent Hires
# Objective: Find employees hired after Jan 1, 2023
select 
employee_id,
concat(first_name," ",last_name)as full_name,
hire_date 
from employees_hr
where hire_date>'2023-01-01'
order by hire_date desc;

# Q4. Completed Training Programs
# Objective: List training programs employees have fully completed.
select
employee_id, training_name,certification_status
from training_hr where certification_status ='completed';

# Q5. Pending Leave Requests
# Objective: Find leave requests still awaiting approval.

select 
leave_id,employee_id,leave_type, total_days, approval_status 
from leave_hr
where approval_status ='pending';

# Q6. Contract Employees
# Objective: Identify all contract (non-permanent) employees.

select 
employee_id, concat(first_name," ",last_name) as full_name, 
gender,address,department_id,job_id from
employees_hr where employment_type = 'contract';

# Q7. Top 5 Highest-Paid Employees
# Objective: Find the five highest-paid employees company-wide.

select 
employee_id,concat(first_name,' ',last_name)as ful_name,salary
from employees_hr order by salary desc 
limit 5;

# Q8. Departments List
# Objective: List all departments with location and budget.

select * from department_hr;

# Q9. Employee Directory with Department & Job Title
# Objective: Build a readable directory instead of raw ID codes.

select
employee_id, concat(first_name,' ',last_name) as full_name,
department_name,job_title 
from department_hr inner join employees_hr using(department_id)
inner join jobs_hr using(job_id);

# Q10. Headcount per Department 
select 
department_name, count(employee_id) as headcount
from employees_hr inner join department_hr using(department_id)
group by 1 order by headcount desc;

# Q11. Average Salary per Department

select 
department_name,round(avg(salary),2)as avg_salary 
from employees_hr inner join department_hr using(department_id)
group by 1 order by avg_salary desc;

# Q12. Average KPI Score per Department
select
department_name, round(avg(kpi_score),2) as avg_kpi
from department_hr inner join employees_hr using(department_id)
inner join performance_hr using(employee_id)
group by 1 ;

# Q13. Direct Reports per Manager

SELECT Manager_ID, COUNT(*) AS direct_reports
FROM employees_hr
WHERE Manager_ID IS NOT NULL
GROUP BY Manager_ID
ORDER BY direct_reports DESC
LIMIT 10;
select manager_id  from employees_hr
WHERE Manager_ID IS NOT NULL;

# Q14. Training Spend per Department
select department_name, sum(training_cost) as training_costt from 
training_hr inner join employees_hr using(employee_id)
inner join department_hr using(department_id) group by 1
order by training_costt desc;

# Q15. Leave Requests by Type 
select
employee_id,concat(first_name," ",last_name)as full_name,
gender,leave_type 
from leave_hr inner join employees_hr using(employee_id);

select leave_type,count(*)as request_count, round(avg(total_days),1) as avg_days 
from leave_hr
group by leave_type order by request_count desc;

# Q16. Working Hours & Overtime by Shift

SELECT Shift, ROUND(AVG(Working_Hours),2) AS avg_hours, ROUND(AVG(Overtime_Hours),2) AS avg_overtime
FROM attendance_hr
GROUP BY Shift;

# Q17. Monthly Payroll Payout
