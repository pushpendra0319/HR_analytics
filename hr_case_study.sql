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

# there is 2 type solution 1 solution from cte
with cte as
(select 
	department_name, employee_id, first_name,salary,
    rank() over(partition by department_name order by salary desc) as salary_rank
    from employees_hr inner join department_hr using(department_id))
    select* from cte
    where salary_rank <=3
    limit 12;

# 2 solution with subquery

    SELECT Department_Name, First_Name, Last_Name, Salary, salary_rank
FROM (
    SELECT d.Department_Name, e.First_Name, e.Last_Name, e.Salary,
           RANK() OVER (PARTITION BY d.Department_Name ORDER BY e.Salary DESC) AS salary_rank
    FROM employees_hr e
    JOIN department_hr d ON e.Department_ID = d.Department_ID
) ranked
WHERE salary_rank <= 3
ORDER BY Department_Name, salary_rank
LIMIT 12;

# Explaination : Finance's top earner (₹2,56,500) earns 3x more than Administration's
# top earner (₹82,000). This stark contrast explains why Administration has lower 
# satisfaction and performance scores — the same seniority level is compensated 
# very differently across departments.


# Q25. Are there any employees being paid below the minimum salary
# defined for their job role — a potential compliance issue?

SELECT e.Employee_ID, e.First_Name, e.Last_Name, e.Salary, j.Job_Title, j.Minimum_Salary
FROM employees_hr e
JOIN jobs_hr j ON e.Job_ID = j.Job_ID
WHERE e.Salary < j.Minimum_Salary
LIMIT 15;

# Explaination:Every single employee is paid at or above the minimum salary
# defined for their role. This is a strong compliance signal and should be 
# explicitly documented in the project report — it shows the company's payroll
# is clean and internally consistent.

#==================================================================================

# Q26. Which managers have more than 10 direct reports — 
# and what structural risk does this create

SELECT m.Employee_ID AS Manager_ID, m.First_Name, m.Last_Name,
       COUNT(e.Employee_ID) AS team_size
FROM employees_hr e
JOIN employees_hr m ON e.Manager_ID = m.Employee_ID
GROUP BY m.Employee_ID, m.First_Name, m.Last_Name
HAVING COUNT(e.Employee_ID) > 10
ORDER BY team_size DESC;

# Explaination : 9 managers exceed the 10-report threshold. Tariq Gonzalez manages
# 15 — nearly double the safe limit. These managers cannot meaningfully coach or 
# support their teams. HR should immediately review these structures and consider 
# adding team leads or redistributing reports.

#=======================================================================================

# Q27. What percentage of each department's workforce has exited — 
# which departments are at crisis-level attrition?

SELECT d.Department_Name,
       COUNT(DISTINCT ex.Employee_ID) AS exited,
       COUNT(DISTINCT e.Employee_ID) AS total,
       ROUND(100.0 * COUNT(DISTINCT ex.Employee_ID) / COUNT(DISTINCT e.Employee_ID), 2) AS attrition_rate_pct
FROM employees_hr e
JOIN department_hr d ON e.Department_ID = d.Department_ID
LEFT JOIN exit_hr ex ON e.Employee_ID = ex.Employee_ID
GROUP BY d.Department_Name
ORDER BY attrition_rate_pct DESC;

# Explaination : Customer Support and QA are in crisis — nearly 4 in 10 employees
# have left. Finance has the lowest attrition (25.69%) and also pays above average.
# The pattern is clear: higher pay = lower attrition. This should be the primary 
# recommendation of the project

#============================================================================================

# Q28. Which employees are rated 'Excellent' in performance but are NOT being 
# recommended for promotion — creating a serious retention risk?

SELECT e.Employee_ID, e.First_Name, e.Last_Name,
       p.Overall_Rating, p.Promotion_Recommendation
FROM performance_hr p
JOIN employees_hr e ON p.Employee_ID = e.Employee_ID
WHERE p.Overall_Rating = 'Excellent' AND p.Promotion_Recommendation = 'No'
LIMIT 15;

# Explaination : Multiple Excellent-rated employees are being passed over for promotion.
# If these individuals are not given a clear growth path, the company will lose 
# its best people to competitors who will offer what they deserve. This list 
# should go directly to department heads for immediate action.

#===========================================================================================

# Q29. Do employees who eventually leave the company earn significantly less than
# those who stay — proving pay is a direct attrition driver?

SELECT e.Employment_Status, ROUND(AVG(p.Net_Salary),2) AS avg_net_salary
FROM payroll_hr p
JOIN employees_hr e ON p.Employee_ID = e.Employee_ID
GROUP BY e.Employment_Status;

# Explaination : Terminated employees earned ₹1,316 less per month (17% lower) 
# than active employees. This is statistically significant — lower-paid employees
# are measurably more likely to leave. This single finding makes the business case
# for salary reviews in high-attrition departments.

#===============================================================================================

# Q30. Which single calendar month had the highest total payroll cost — 
# and what does this reveal about the company's staffing peak?
SELECT Payroll_Month, ROUND(SUM(Net_Salary),2) AS total_payout
FROM payroll_hr
GROUP BY Payroll_Month
ORDER BY total_payout DESC
LIMIT 1;

# Explaination : May 2025 is the company's payroll peak — confirming headcount 
# was at its all-time high in the most recent month of the dataset. Any significant
#  attrition going forward would noticeably reduce this figure, directly impacting productivity.

#=========================================================================================================

# Q31. Which employees show a declining KPI score between their first and 
# most recent review — signaling deteriorating performance?

SELECT p1.Employee_ID, p1.KPI_Score AS first_kpi, p2.KPI_Score AS latest_kpi
FROM performance_hr p1
JOIN performance_hr p2 ON p1.Employee_ID = p2.Employee_ID
JOIN (
    SELECT Employee_ID, MIN(Review_Date) AS min_date, MAX(Review_Date) AS max_date
    FROM performance_hr GROUP BY Employee_ID HAVING COUNT(*) >= 2
) d ON p1.Employee_ID = d.Employee_ID AND p1.Review_Date = d.min_date
     AND p2.Employee_ID = d.Employee_ID AND p2.Review_Date = d.max_date
WHERE p2.KPI_Score < p1.KPI_Score
LIMIT 10;

# Explaination :  E00001 dropped nearly 24 KPI points — the sharpest decline. 
# E00009 (Hassan Rodrigues) also appears here AND in Q28 (Excellent rating, no promotion).
# A declining KPI combined with no growth path is a near-certain attrition predictor.
# These employees need urgent manager check-ins.

#==========================================================================================

# Q32. Do employees who work more overtime have lower attendance scores —
# does overwork lead to disengagement?

SELECT
    CASE WHEN a.avg_overtime < 1 THEN 'Low Overtime'
         WHEN a.avg_overtime < 3 THEN 'Medium Overtime'
         ELSE 'High Overtime' END AS overtime_bucket,
    ROUND(AVG(p.Attendance_Score),2) AS avg_attendance_score
FROM (SELECT Employee_ID, AVG(Overtime_Hours) AS avg_overtime
      FROM attendance_hr GROUP BY Employee_ID) a
JOIN performance_hr p ON a.Employee_ID = p.Employee_ID
GROUP BY overtime_bucket;

# Explaination : All employees fall into "Low Overtime" — the company does
# not currently have an overwork problem at the dataset level. 
# Attendance scores average 80.03, which is healthy. However, 
# team-level spikes may be hidden in this aggregate — HR should monitor by department.

#===============================================================================================

# EXPERT BUSINESS CASE STUDIES - 

# Q33. What are the top exit reasons by type — 
# and does notice period differ between voluntary and involuntary exits?

SELECT Exit_Type, Exit_Reason, COUNT(*) AS cnt,
       ROUND(AVG(Notice_Period),1) AS avg_notice_days
FROM exit_hr
GROUP BY Exit_Type, Exit_Reason
ORDER BY Exit_Type, cnt DESC;

# Explaination : Layoff / Restructuring exits give only 22.7 days notice — the shortest.
# This means restructuring events create the most abrupt operational gaps.
# HR should maintain stronger succession and knowledge transfer plans specifically
# for restructuring scenarios.

#===============================================================================================






