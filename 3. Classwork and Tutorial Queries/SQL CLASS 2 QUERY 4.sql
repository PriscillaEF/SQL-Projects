-- ADVANCED MYSQL 

-- CTEs

with cte_example As
(
select gender, avg(salary) avg_sal, max(salary) max_sal, min(salary) min_sal, count(salary) count_sal
from employee_demographics d
join employee_salary s
	on d.employee_id = s.employee_id
group by gender
)

select avg(avg_sal)
from cte_example
;

-- same as 

select avg(avg_sal)
from(
select gender, avg(salary) avg_sal, max(salary) max_sal, min(salary) min_sal, count(salary) count_sal
from employee_demographics d
join employee_salary s
	on d.employee_id = s.employee_id
group by gender
)  example_subquery
;

with cte_example (Gender, max_sal, min_sal, avg_sal, count_sal) As
(
select gender, avg(salary) avg_sal, max(salary) max_sal, min(salary) min_sal, count(salary) count_sal
from employee_demographics d
join employee_salary s
	on d.employee_id = s.employee_id
group by gender
)

select *
from cte_example
;


with cte_example1 As
(
select employee_id, gender, birth_date
from employee_demographics d
where birth_date > '1985-01-01'
),
cte_example2  as(
select *
from employee_salary
where salary > 50000)
select *
from cte_example1
join cte_example2 
	on cte_example1.employee_id = cte_example2.employee_id
    
;


-- TEMP TABLES (ONLY VISIBLE TO THE SESSION THAT THEY ARE CREATED IN)

create temporary table temp_table
(first_name varchar(50),
last_name varchar(50),
favorite_movie varchar(100)
)
;

select *
from temp_table;

insert into temp_table
values('Alex', 'Freberg', 'Lord of the Rings: The Two Towers'),
('Priscilla', 'Fanama', 'Avatar the Airbender');

select *
from employee_salary;

create temporary table salary_over_50k
select *
from employee_salary
where salary > 50000
;

select *
from salary_over_50k;

-- STORED PROCEDURES

select *
from employee_salary
where salary >= 50000;


create procedure large_salaries()
select *
from employee_salary
where salary >= 50000;

call large_salaries();

-- delimiter //, $$ (used to combine queries)

delimiter $$
create procedure large_salaries3()
begin
	select *
	from employee_salary
	where salary >= 50000;
	select *
	from employee_salary
	where salary >= 50000;
end $$
delimiter ;


call large_salaries3();

-- PARAMETERS -- VARIABLES PASSED AS INPUT INTO THE STORE PROCEDURE

delimiter $$ 
create procedure large_salaries4(p_employee_id INT)
begin
	select salary
	from employee_salary
    where employee_id = p_employee_id
	;
end $$
delimiter ;

call large_salaries4(2);

-- TRIGGERS AND EVENTS (Trigger is a block of code that executes automatically when an event takes place on a table)

delimiter $$ 
create trigger employee_insert
	after insert on employee_salary
    for each row
begin
	insert into employee_demographics (employee_id, first_name, last_name)
    values (new.employee_id, new.first_name, new.last_name);
end $$
delimiter ;

insert into employee_salary (employee_id, first_name, last_name, occupation,salary, dept_id)
values(13, 'Jean-Ralphio', 'Saperstein', 'Entertainment 720 CED', 1000000, null);

select *
from employee_demographics;

select *
from employee_salary;

-- events (takes place when it's scheduled)

delimiter $$
create event delete_retirees
on schedule every 30 second
do
begin
	delete 
	from employee_demographics
    where age >=60;
end $$
delimiter ;

select *
from employee_demographics;

show variables like 'event%';














