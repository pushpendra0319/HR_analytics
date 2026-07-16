# HR Analytics SQL Project

## Project Overview

This project is a complete **HR Analytics SQL Project** designed to simulate real-world HR data analysis and reporting. The database was built from scratch using MySQL and consists of **10 relational tables** covering employee information, departments, jobs, attendance, payroll, performance, recruitment, training, leave management, and employee exits.

The project demonstrates the full data analysis workflow:

* Database design and schema creation
* Data import from CSV files
* Data cleaning and validation
* Primary and foreign key implementation
* Relational database modeling
* SQL-based business analysis
* HR case study problem solving

The goal of this project is to showcase practical SQL skills and business-oriented analytics that are commonly required for **Data Analyst, MIS Analyst, and HR Analytics** roles.

---

## Project Objectives

* Build a relational HR database using MySQL
* Establish relationships between multiple business entities
* Practice SQL from beginner to advanced level
* Solve real HR business problems using SQL
* Generate insights related to employees, payroll, attendance, recruitment, training, and attrition
* Create a portfolio-ready project suitable for interviews and GitHub

---

## Dataset Information

The project contains **10 tables**. Replace the row counts below with the actual values from your database using `SELECT COUNT(*) FROM table_name;`.

| Table Name       | Row Count | Description                                                                               |
| ---------------- | --------- | ----------------------------------------------------------------------------------------- |
| `department_hr`  | ___       | Stores department information such as department name, location, and budget.              |
| `jobs_hr`        | ___       | Contains job roles, grades, and salary ranges.                                            |
| `employees_hr`   | ___       | Master employee table containing personal, employment, salary, and manager information.   |
| `attendance_hr`  | ___       | Daily attendance records including check-in, check-out, working hours, and overtime.      |
| `leave_hr`       | ___       | Employee leave requests, leave types, dates, and approval status.                         |
| `payroll_hr`     | ___       | Monthly payroll data including salary, allowances, deductions, tax, and net salary.       |
| `performance_hr` | ___       | Employee performance reviews, KPI scores, ratings, and promotion recommendations.         |
| `recruitment_hr` | ___       | Recruitment process data including candidates, interviews, recruiters, and hiring status. |
| `training_hr`    | ___       | Employee training programs, providers, costs, and certification status.                   |
| `exit_hr`        | ___       | Employee exit records including exit date, reason, notice period, and final rating.       |

---

## Database Schema

### Primary Relationships

* `employees_hr.Department_ID` → `department_hr.Department_ID`
* `employees_hr.Job_ID` → `jobs_hr.Job_ID`
* `employees_hr.Manager_ID` → `employees_hr.Employee_ID` (self-relationship)
* `attendance_hr.Employee_ID` → `employees_hr.Employee_ID`
* `leave_hr.Employee_ID` → `employees_hr.Employee_ID`
* `payroll_hr.Employee_ID` → `employees_hr.Employee_ID`
* `performance_hr.Employee_ID` → `employees_hr.Employee_ID`
* `performance_hr.Reviewer_ID` → `employees_hr.Employee_ID`
* `recruitment_hr.Department_ID` → `department_hr.Department_ID`
* `recruitment_hr.Recruiter_ID` → `employees_hr.Employee_ID`
* `training_hr.Employee_ID` → `employees_hr.Employee_ID`
* `exit_hr.Employee_ID` → `employees_hr.Employee_ID`

---

## Tools & Technologies Used

* **Database:** MySQL 8.0
* **Database Client:** MySQL Workbench
* **Version Control:** Git & GitHub
* **Data Format:** CSV
* **Analytics:** SQL (MySQL)
* **Future Extension:** Power BI Dashboard

---

## SQL Concepts Covered

This project demonstrates a wide range of SQL concepts:

### Database Design

* `CREATE DATABASE`
* `CREATE TABLE`
* Primary Keys
* Foreign Keys
* One-to-Many Relationships
* Self Joins

### Data Import & Cleaning

* `LOAD DATA INFILE`
* Handling `NULL` values
* Data type validation
* Data cleaning using `UPDATE`

### Querying & Analysis

* `SELECT`
* `WHERE`
* `ORDER BY`
* `LIMIT`
* `DISTINCT`
* `LIKE`
* `IN`
* `BETWEEN`

### Aggregation

* `COUNT()`
* `SUM()`
* `AVG()`
* `MIN()`
* `MAX()`
* `GROUP BY`
* `HAVING`

### Joins

* `INNER JOIN`
* `LEFT JOIN`
* `SELF JOIN`
* Multi-table joins

### Advanced SQL

* Subqueries
* Correlated Subqueries
* Common Table Expressions (CTEs)
* Window Functions
* Ranking Functions
* Date Functions (`DATE_SUB`, `YEAR`, `MONTH`, etc.)

---

## Case Study Summary

As part of this project, I solved **40 HR Analytics SQL case study questions** covering beginner to advanced business scenarios. The case studies focused on:

### Employee Analysis

* Total employee count
* Active vs exited employees
* Gender distribution
* Employee experience analysis

### Department Analysis

* Employees by department
* Department-wise salary analysis
* Department performance comparison

### Payroll Analysis

* Total payroll expense
* Average salary by job role
* Highest and lowest paid employees
* Salary distribution analysis

### Attendance & Leave Analysis

* Attendance trends
* Overtime analysis
* Leave utilization
* Employees with low attendance

### Performance Analysis

* Top performers
* Department-wise performance ratings
* Promotion recommendations
* Performance score comparisons

### Recruitment Analysis

* Hiring success rate
* Recruiter performance
* Department-wise recruitment activity

### Training Analysis

* Training participation
* Training cost analysis
* Certification completion status

### Attrition & Exit Analysis

* Employee attrition analysis
* Exit reasons
* Notice period analysis
* Salary impact of employee exits

These case studies were designed to simulate real business questions asked by HR managers, finance teams, and company leadership.

---

## Project Structure

```
HR-Analytics-SQL-Project/
│
├── README.md
├── Dataset/
├── SQL Scripts/
├── Images/
└── Documentation/
```

---

## Key Learnings

Through this project, I learned how to:

* Design a relational database
* Import and clean real-world data
* Build and manage foreign key relationships
* Write efficient SQL queries
* Solve business-oriented analytics problems
* Use SQL for HR reporting and decision-making
* Organize and document a portfolio project professionally

---

## Future Enhancements

* Build an interactive **Power BI HR Dashboard**
* Add advanced SQL optimization techniques
* Create stored procedures and views
* Automate reporting workflows
* Publish insights and dashboards on GitHub and LinkedIn

---

## Author

**Pushpendra Verma**

* Mechanical Engineering Graduate (2019)
* MIS Executive / Aspiring Data Analyst
* Skilled in Excel, SQL, Power BI, and HR Analytics

---

⭐ If you found this project useful, feel free to explore the SQL scripts and case studies in this repository.
