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
