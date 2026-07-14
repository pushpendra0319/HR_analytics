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
select * from payroll_hr;
select payroll_month, round(sum(net_salary),2) as total_salary from 
payroll_hr  group by 1
order by payroll_month ;

# Q18. What are the most common reasons employees are leaving — 
# and does the exit type change the pattern significantly?

select exit_type, exit_reason, count(*) as exit_count
from exit_hr group BY 1,2
ORDER BY EXIT_COUNT DESC;             

# Explanation :
# 72% of all exits are voluntary and therefore preventable. The top reason — "Better Opportunity" — 
# means the company is losing talent to competitors. HR must focus on career growth programs 
# and compensation reviews to close this gap.

# Q19. Which departments are recruiting the most candidates — 
# is this driven by growth or by constant replacement of people who keep leaving?

select 
	department_name, count(*) as applications
    from recruitment_hr inner join department_hr 
    using (department_id)
group by 1
order by applications desc;

# Explanation:  QA recruits the most (798 applications) AND has the second-highest attrition 
# (38.28%). This is a classic replacement cycle — QA is hiring to replace people who leave, 
# not to grow. The cost of constantly recruiting for QA roles should be a wake-up call for leadership.


# Which departments are recruiting the most candidates — 
# is this driven by growth or by constant replacement of people who keep leaving?

select 
	department_name,hiring_status, count(*) as total_aplications 
    from recruitment_hr inner join department_hr using(department_id)
    where hiring_status = 'Hired'
group by 1,2
order by total_aplications desc;


# Q20. Does a candidate's interview score actually predict whether they get hired — 
# or are hiring decisions being made subjectively?

SELECT Hiring_Status, ROUND(AVG(Interview_Score),2) AS avg_score, COUNT(*) AS candidates
FROM recruitment_hr
GROUP BY Hiring_Status
ORDER BY avg_score DESC;

# Explanation : The difference between Hired (65.24) and Rejected (64.60) is less than 1 point. 
# Interview scores are barely influencing hiring decisions. This means the process relies heavily 
# on subjective factors — a major red flag for consistency and fairness that HR should investigate.

#================================================================================================================

# Q21. Which departments pay above the company-wide average salary — 
# and which are falling behind competitively?
 
 select department_name, round(avg(salary),2) as avg_salary 
 from employees_hr inner join department_hr using(department_id)
 group by 1
 having avg_salary >(select avg(salary) from employees_hr)
 order by avg_salary desc;

 
 select avg (salary) as a_salary from employees_hr ;
 
 select department_name, round(avg(salary),2) as avg_salary 
 from employees_hr inner join department_hr using(department_id)
 group by 1;
 
# Explaation :
# Only 6 of 12 departments pay above the company average. The 6 below-average departments — 
# which include Customer Support and Administration — are also the ones with the highest attrition. 
# Pay below the average directly correlates with people leaving.
 #=================================================================================================================
 
 # Q22. Which employees have never taken any leave at all — and should they be flagged as potential burnout risks?
 

    
select 
	employee_id, concat(first_name,' ',last_name) as emp_fullname
    from employees_hr left join leave_hr using(employee_id) 
where leave_id is null;

# Explaination : 254 employees (8.5% of the workforce) have never taken any leave. 
# These employees should be proactively contacted by their managers. Burnout from never 
# resting often precedes sudden, unexpected resignations.

#=========================================================================================================

# Q23. Which employees have completed more than 3 training programs — and 
#  are these highly-trained employees being retained and rewarded?

select 
	employee_id, concat(first_name," ",last_name)as emp_fullname,
    count(taining_id)as training_taken 
from employees_hr inner join training_hr using (employee_id)
group by 1,2
having training_taken >3
order by training_taken desc;

# Explaination : Several employees have completed the maximum 6 training programs 
# and also show strong KPI scores. These are your most invested employees — 
# if they are not being promoted, they will find growth elsewhere. Cross-reference 
# with Q28 (excellent performers not recommended for promotion) for urgent action.

#==========================================================================================

#Q24. Who are the top 3 highest-earning employees within each 
# specific department — not just company-wide?

select 
	department_name, employee_id, first_name,salary,
    dense_rank() over(partition by department_name order by salary desc) as salary_rank
    from employees_hr inner join department_hr using(department_id)
    limit 3;
    