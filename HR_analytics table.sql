create database HR_analytics;
use HR_analytics;
show tables;

drop table department_hr;

Create table Department_HR(
Department_ID varchar(10) primary key, 
Department_name varchar(100),
Location varchar(100),
Budget Decimal (12,2),
Head_Employee_ID varchar(10)
);



set global local_infile = 1;
show variables like 'secure_file_priv';

show variables like 'local_infile';


load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Departments_HR.csv"
into table Department_HR 
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(Department_ID, Department_name,Location,Budget,Head_Employee_ID);

select * from department_hr;
desc department_hr; 

#========================================================================================

# 2 job_hr table

create table jobs_hr(
Job_ID varchar(10) primary key,
Job_title varchar(100),
Grade varchar(20),
Minimum_salary decimal(10,2),
Maximum_salary decimal(10,2)
);


load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Jobs_HR.csv"
into table jobs_HR 
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select * from jobs_hr;

#==============================================================================================

# 3 employees_hr

create table Employees_hr(
Employee_ID varchar(10) primary key,
First_name varchar(50), last_name varchar(50),
Gender varchar(10), Date_of_birth date,
Email varchar(100), phone varchar(20),
Address varchar(255), Hire_Date DATE, 
Department_ID varchar(10), Job_ID varchar(10),
Manager_ID varchar(10), Salary decimal (10,2),
Bonus decimal(10,2), Employment_Status varchar(30),
Employment_Type varchar(30), Education varchar(100),
Experience_Years int
);

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Employees_HR.csv"
into table Employees_hr 
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\n'
ignore 1 rows;



select * from employees_hr;


#=================================================================================================

# 4 Attendance_hr

create table Attendance_hr(
Attendance_ID varchar(10) primary key,
Employee_ID varchar(10), Attendace_Date DATE,
Check_IN Time, Check_Out time,
Working_hours decimal(4,2), Overtime_hours decimal(4,2),
Attendance_Status varchar(20), Shift varchar(20)
);

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Attendance_HR.csv"
into table Attendance_hr 
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

Select * from Attendance_hr;
#============================================================================================

# 5 Leave_hr 

create table Leave_HR(
Leave_ID varchar(10) primary key,
Employee_ID varchar(10), Leave_Type varchar(50),
Start_Date date, End_Date date,
Total_Days int, Approval_Status varchar(20)
);

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Leave_HR.csv"
into table Leave_HR 
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

Select * from leave_hr;

#=====================================================================================================

# 6 Payroll_HR

create table Payroll_HR(
Payroll_ID varchar(10) primary key,
Employee_ID varchar(10),
Payroll_Month varchar(20),
Basic_Salary decimal(10,2),
Allowances decimal (10,2),
Bonus Decimal (10,2), Tax decimal (10,2),
Deductions decimal(10,2),
Net_Salary decimal(10,2),
Payment_Date date
);


load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Payroll_HR.csv"
into table Payroll_HR 
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select* from payroll_hr;

#=====================================================================================

# 7 Performance_HR

create table Performance_HR(
Performance_ID varchar(10) primary key,
Employee_ID varchar(10),
Review_date date, Reiviewer_ID varchar(10),
KPI_Score decimal(5,2),
Productivity_Score decimal(5,2),
Attendance_Score decimal(5,2),Teamwork_Score decimal(5,2),
Overall_Rating varchar(20), 
Promotion_Recommendation varchar(20)
);


load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Performance_HR.csv"
into table Performance_HR 
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select * from performance_hr;

#====================================================================================================

# 8 Recruitment_HR

create table Recruitment_HR(
Recruitment_ID varchar(10) primary key,
Candidate_ID varchar(10),
Candidate_name varchar(100),
Position varchar(100),
Department_ID varchar(10),
Application_Date date,
Interview_Date date, Recruiter_ID varchar(10),
Interview_Score decimal(5,2),
Hiring_Status varchar(20),
Joining_Date date
);


load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Recruitment_HR.csv"
into table Recruitment_HR 
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(
Recruitment_ID,
Candidate_ID,
Candidate_name,
Position,
Department_ID,
Application_Date,
Interview_Date, Recruiter_ID,
Interview_Score,
Hiring_Status,
@Joining_Date
)
set Joining_date = nullif(@joining_date,'');

select * from recruitment_hr;

#==========================================================================================

# 9 Training_Hr

create table Training_HR(
Taining_ID varchar(10) primary key,
Employee_ID varchar(10),
Training_Name varchar(100),
Provider varchar (100),
Start_Date date,End_Date date,
Training_Cost decimal(10,2),
Certification_Status varchar(30)
);

load data infile 
"C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Training_HR.csv"
into table Training_HR 
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select * from training_hr;

show tables;
#============================================================================================================

# 10 Exit_HR

create table Exit_HR(
Exit_ID varchar(10) primary key,
Employee_ID varchar(10),
Exit_Date date, Exit_Reason varchar(100),
Exit_Type varchar(30),
Notice_Period INT,
Final_Rating varchar(30)
);

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Exit_HR.csv"
into table Exit_HR 
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select * from exit_hr;

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

 # ADD Constraints
# Employees -> Department

alter table employees_hr
add constraint fk_emp_department
foreign key (department_ID)
references department_hr(department_id);

# Empoyees -> Jobs

alter table employees_hr
add constraint fk_emp_job
foreign key(job_id)
references jobs_hr(job_id);

# Employees -> Manager (self relationship)


#______________________________________________________________________________________________________________
# in this process we have changed emptiy string ('') into null in column manager_id than run 
# this sql_safe command and sucessfully change 764 rows into null and now we ready to add foreign_key in manager_id.
set sql_safe_updates =0;

update employees_hr
set manager_id = null
where manager_id = '';

select manager_id from employees_hr where manager_id is null;

select distinct manager_id
from employees_hr
where manager_id is not null and manager_id not in (
select employee_id from employees_hr);

# add foreign key

alter table employees_hr
add constraint fk_emp_manager
foreign key(manager_id)
references employees_hr(employee_id);

#==================================================================================================================

# Attendance -> Employees

alter table attendance_hr
add constraint fk_attendance_employee
foreign key(employee_id)
references employees_hr(employee_id);

# Leave -> Employees

alter table leave_hr
add constraint fk_leave_employee
foreign key(employee_id)
references employees_hr(employee_id);

#payroll -> employees

alter table payroll_hr
add constraint fk_payroll_employee
foreign key(employee_id)
references employees_hr(employee_id);

# Performance -> Reviewer

alter table performance_hr
add constraint fk_performance_reviewer 
foreign key (reiviewer_id)
references employees_hr(employee_id);

# Recruitment -> department

alter table recruitment_hr
add constraint fk_recruitment_department
foreign key(department_id)
references department_hr(department_id);

# Recruitment -> Recruiter

alter table recruitment_hr
add constraint fk_recruitment_recruiter
foreign key(recruiter_id)
references employees_hr(employee_id);

# Training -> Employees

alter table training_hr
add constraint fk_training_employee
foreign key(Employee_ID)
references employees_hr(employee_id);

# Exit -> EMpoyees

alter table exit_hr
add constraint fk_exit_employee
foreign key(employee_id)
references employees_hr(employee_ID);



select * from exit_hr cross join employees_hr using (employee_id);
select * from exit_hr;
select * from employees_hr;

