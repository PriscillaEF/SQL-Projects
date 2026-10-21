-- Assignment
create database Rahitech_ace
Use Rahitech_ace

-- Create students table
create table Students(
 StudentID int primary key not null,
 FirstName varchar(30),
 LastName varchar(30),
 DateOfBirth date,
 GradeLevel varchar(1)
);

-- Create Teachers table
create table Teachers (
 TeacherID int primary key not null,
 FirstName varchar(30),
 LastName varchar(30),
 SunjectTaught varchar(30),
 ContactInfo varchar(30)
);

-- Create Courses table
create table courses (
 CourseID int primary key not null,
 CourseName varchar(30),
 CourseDescription varchar(100)
);

-- Create Classes table
create table Classes (
 ClassID int primary key not null,
 TeacherID int foreign key (TeacherID) references Teachers(TeacherID),
 CourseID int foreign key (CourseID) references Courses(CourseID),
 Schedule varchar(50)
);

-- Create Grades table
create table Grades (
 GradeID int primary key not null,
 StudentID int foreign key (StudentID) references Students(StudentID),
 CourseID int foreign key (CourseID) references Courses(CourseID),
 Grade varchar(3)
);

Drop table Grades

-- Create Departments table
create table Departments (
 DepartmentID int primary key not null,
 DepartmentName varchar(50)
);

-- Create attendance table
create table attendance (
 AttendanceID int primary key,
 StudentID int foreign key (StudentID) references Students(StudentID),
 ClassID int foreign key (ClassID) references Classes(ClassID),
 AttendanceDate date
);

-- Create fees table
create table fees (
 FeeID int primary key,
 StudentID int foreign key (StudentID) references Students(StudentID),
 FeeType varchar(50),
 Amount decimal(10,5),
 PaymentDate date
);

-- Insert data into students table
INSERT INTO Students (StudentID, FirstName, LastName, DateOfBirth, GradeLevel)
VALUES
(1, 'John', 'Doe', '2005-06-15', '10'),
(2, 'Jane', 'Smith', '2006-07-20', '9'),
(3, 'Michael', 'Brown', '2004-05-10', '11'),
(4, 'Emily', 'Davis', '2005-12-30', '10'),
(5, 'Matthew', 'Wilson', '2006-08-14', '9'),
(6, 'Sophia', 'Taylor', '2005-09-21', '10'),
(7, 'Daniel', 'Anderson', '2004-11-02', '11'),
(8, 'Emma', 'Thomas', '2006-03-25', '9'),
(9, 'Olivia', 'Jackson', '2005-01-18', '10'),
(10, 'Liam', 'White', '2004-07-29', '11');

Alter table Students
alter column GradeLevel varchar(5)

select * from Students

-- Insert data into teachers table
INSERT INTO Teachers (TeacherID, FirstName, LastName, SunjectTaught, ContactInfo)
VALUES
(1, 'Alice', 'Johnson', 'Math', 'alice.johnson@rahitech_ace.edu'),
(2, 'Robert', 'Lee', 'Science', 'robert.lee@rahitech_ace.edu'),
(3, 'Mary', 'Clark', 'History', 'mary.clark@rahitech_ace.edu'),
(4, 'David', 'Hall', 'English', 'david.hall@rahitech_ace.edu'),
(5, 'Susan', 'Miller', 'Art', 'susan.miller@rahitech_ace.edu'),
(6, 'James', 'Martinez', 'Math', 'j.martinez@rahitech_ace.edu'),
(7, 'Linda', 'Garcia', 'Science', 'linda.garcia@rahitech_ace.edu'),
(8, 'William', 'Rodriguez', 'History', 'w.rodriguez@rahitech_ace.edu'),
(9, 'Barbara', 'Martinez', 'English', 'b.martinez@rahitech_ace.edu'),
(10, 'Thomas', 'Hernandez', 'Art', 't.hernandez@rahitech_ace.edu');

-- Rename column
EXEC sp_rename 'Teachers.SunjectTaught', 'SubjectTaught', 'COLUMN';

select * from Teachers

-- Insert data into courses table
INSERT INTO Courses (CourseID, CourseName, CourseDescription)
VALUES
(1, 'Algebra', 'An introduction to algebraic principles.'),
(2, 'Biology', 'Fundamentals of biological sciences.'),
(3, 'World History', 'A survey of world history from ancient times to present.'),
(4, 'Literature', 'Study of classic and modern literature.'),
(5, 'Drawing', 'Basic techniques in drawing and sketching.');

-- Insert data into classes table
INSERT INTO Classes (ClassID, TeacherID, CourseID, Schedule)
VALUES
(1, 1, 1, 'MWF 9:00-10:00 AM'),
(2, 2, 2, 'TTh 10:00-11:30 AM'),
(3, 3, 3, 'MWF 11:00 AM-12:00 PM'),
(4, 4, 4, 'TTh 1:00-2:30 PM'),
(5, 5, 5, 'MWF 2:00-3:00 PM'),
(6, 6, 1, 'MWF 9:00-10:00 AM'),
(7, 7, 2, 'TTh 10:00-11:30 AM'),
(8, 8, 3, 'MWF 11:00 AM-12:00 PM'),
(9, 9, 4, 'TTh 1:00-2:30 PM'),
(10, 10, 5, 'MWF 2:00-3:00 PM');

select * from Classes

-- Insert into Grades table
INSERT INTO Grades VALUES
(1, 1, 1, 'A'),
(2, 2, 2, 'B'),
(3, 3, 3, 'A'),
(4, 4, 4, 'C'),
(5, 5, 5, 'B'),
(6, 6, 1, 'A'),
(7, 7, 2, 'C'),
(8, 8, 3, 'B'),
(9, 9, 4, 'A'),
(10, 10, 5, 'B');

-- Insert data into department table
INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES
(1, 'Mathematics'),
(2, 'Science'),
(3, 'History'),
(4, 'English'),
(5, 'Arts'),
(6, 'Physical Education'),
(7, 'Computer Science'),
(8, 'Music'),
(9, 'Languages'),
(10, 'Social Studies');

-- Insert into attendance table
INSERT INTO Attendance (AttendanceID, StudentID, ClassID, AttendanceDate)
VALUES
(1, 1, 1, '2024-07-01'),
(2, 2, 2, '2024-07-01'),
(3, 3, 3, '2024-07-01'),
(4, 4, 4, '2024-07-01'),
(5, 5, 5, '2024-07-01'),
(6, 6, 6, '2024-07-01'),
(7, 7, 7, '2024-07-01'),
(8, 8, 8, '2024-07-01'),
(9, 9, 9, '2024-07-01'),
(10, 10, 10, '2024-07-01');

-- Insert data into fees table
INSERT INTO Fees (FeeID, StudentID, FeeType, Amount, PaymentDate)
VALUES
(1, 1, 'Tuition', 1500.00, '2024-01-10'),
(2, 2, 'Tuition', 1500.00, '2024-01-10'),
(3, 3, 'Tuition', 1500.00, '2024-01-10'),
(4, 4, 'Tuition', 1500.00, '2024-01-10'),
(5, 5, 'Tuition', 1500.00, '2024-01-10'),
(6, 6, 'Tuition', 1500.00, '2024-01-10'),
(7, 7, 'Tuition', 1500.00, '2024-01-10'),
(8, 8, 'Tuition', 1500.00, '2024-01-10'),
(9, 9, 'Tuition', 1500.00, '2024-01-10'),
(10, 10, 'Tuition', 1500.00, '2024-01-10');

select * from fees 

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
select * from Salary

-- a. Adding a new employee to the system.
insert into Employees values 
('John', 'Doe', '1985-05-15', 1, '2024-07-16');

-- b. Updating an employee's department.
update Employees
set DepartmentID = 3 
where  Department = 1;

-- c. Recording salary details for an employee.
insert into Salary(EmployeeID, SalaryAmount, SalaryDate)
values (1, 5000.00, '2024-07-15');

-- d. Finding the total number of employees in each department.
select departmentID, sum(employeeID) as TotalEmployee
group by department

-- e. Retrieving the names of employees who joined in a specific year.
select FirstName, LastName, 
from employees
where year(hiredate) = 2024;

-- f. Calculating the average salary for department.
select departmentID, avg(salary) as Avg_salary
from salary
group by department













