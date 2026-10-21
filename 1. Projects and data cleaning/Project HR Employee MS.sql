-- SQL SCHOOL PROJECT: HR Employee Management System

/* 
Your task is to create a MySQL database for an HR Employee Management System. 
The system should store employee details, department information, and salary data. 
Each employee has details like employee ID, name, date of birth, department ID, and hire date. 
Departments have details like department ID and department name. 
Salary data includes employee ID, salary amount, and the date the salary was recorded.
*/

--Create the database called HR Employee Management System
Create database HR_EMS  
use HR_EMS

create table departments (
DepartmentID int primary key,
DeppartmentName varchar(30)
);

create table Employees(
EmployeeID int identity(1,1) primary key not null,
FirstName varchar(30),
LastName varchar(30),
DateofBirth date,
DepartmentID int foreign key (DepartmentID) references Departments(DepartmentID),
HireDate date
);

select * from Employees

create table Salary(
salaryID int identity (1,1) primary key,
EmployeeID int foreign key (EmployeeID) references Employees(EmployeeID),
SalaryAmount decimal(10,4),
SalaryDate date
);

drop table Salary

select * from Employees
select * from departments
select * from Salary

-- a. Adding a new employee to the system.
insert into Employees values 
('John', 'Doe', '1985-05-15', NULL, '2024-07-16');

-- Insert employee department
insert into departments values 
(1, 'EEE'),
(2, 'PRE');

-- update employee table foreign key
update employees
set DepartmentID = 2 
where EmployeeID = 4;

-- b. Updating an employee's department.
update departments
set DeppartmentName = 'CHE' 
where  DepartmentID = 2;

-- c. Recording salary details for an employee.
insert into Salary(EmployeeID, SalaryAmount, SalaryDate)
values (4, 5000.00, '2024-07-15');

select * from Employees

-- d. Finding the total number of employees in each department.
select d.DepartmentID, d.DeppartmentName, count(e.employeeID) as TotalEmployees
from employees e
right join departments d
on e.DepartmentID = d.DepartmentID
group by d.DepartmentID, d.DeppartmentName

-- e. Retrieving the names of employees who joined in a specific year.
select FirstName, LastName, year(HireDate) as HireYear_2024
from employees
where year(hiredate) = 2024;

-- f. Calculating the average salary for each department.
select d.DepartmentID, d.DeppartmentName, avg(s.SalaryAmount) as Avg_Salary_$
from salary s
left join Employees e
on s.EmployeeID = e.EmployeeID
right join departments d
on e.DepartmentID = d.DepartmentID
group by d.DepartmentID, d.DeppartmentName

