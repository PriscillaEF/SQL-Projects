-- Having vs Where

select gender, avg(age)
from employee_demographics
where avg(age) > 48
group by gender
; -- would not work, having was made for this purpose

select gender, avg(age)
from employee_demographics
group by gender
having avg(age) > 40
; 

select occupation, avg(salary)
from employee_salary
where occupation like '%manager%'
group by occupation
having avg(salary) > 75000;

-- limits & aliasing

select *
from employee_demographics
order by age desc
limit 3;

select *
from employee_demographics
order by age desc
limit 2, 1;

select gender, avg(age) as avg_age
from employee_demographics
group by gender
having avg_age > 40
; 

-- as is implied
select gender, avg(age) avg_age
from employee_demographics
group by gender
having avg_age > 40
; 

-- JOINS 

-- INNER JOIN (Return rows that are the same in both columns from both tables)

select *
from employee_demographics;

select * 
from employee_salary;

select *
from employee_demographics d
inner join employee_salary s
	on d.employee_id = s.employee_id
;


select d.employee_id, age, occupation
from employee_demographics as d
inner join employee_salary as s
	on d.employee_id = s.employee_id
;

-- OUTTER JOINS (Left join, right join, left outter join, right outter join)
-- left join gives you everything on the left table
-- right join gives you everything on the right table

select *
from employee_demographics as d
right join employee_salary as s
	on d.employee_id = s.employee_id
;

-- same as

select *
from employee_salary as d
left join employee_demographics as s
	on d.employee_id = s.employee_id
;
select *
from employee_demographics as d
left join employee_salary as s
	on d.employee_id = s.employee_id
;
-- same as
select *
from employee_salary as d
right join employee_demographics as s
	on d.employee_id = s.employee_id
;

-- self join (say you want to assign people a partner)

select *
from employee_salary s1
join employee_salary s2
	on s1.employee_id + 1 = s2.employee_id
;

select s1.employee_id as emp_santa,
s1.first_name as first_name_santa,
s1.last_name as last_name_santa,
s2.employee_id as emp_ID,
s2.first_name as first_name_emp,
s2.last_name as last_name_emp
from employee_salary s1
join employee_salary s2
	on s1.employee_id + 1 = s2.employee_id
;

-- JOINING MULTIPLE TABLES TOGETHER

select *
from employee_demographics as d
inner join employee_salary as s
	on d.employee_id = s.employee_id
inner join parks_departments pd
	on s.dept_id = pd.department_id
;

-- UNIONS -- allows you to combine rows together, like hstack

select age, gender
from employee_demographics
union
select first_name, last_name
from employee_salary;

select first_name, last_name
from employee_demographics
union distinct
select first_name, last_name
from employee_salary;

select first_name, last_name
from employee_demographics
union all
select first_name, last_name
from employee_salary;

-- USE CASE

select first_name, last_name, 'old_man' as Label
from employee_demographics
where age > 40 and gender = 'Male'
union 
select first_name, last_name, 'old_lady' as Label
from employee_demographics
where age > 40 and gender = 'Female'
union
select first_name, last_name, 'Highly paid employee' as label
from employee_salary
where salary > 70000
order by first_name, last_name
;


