-- SUBQUERIESS

select *
from employee_demographics
where employee_id in 
					( select employee_id
                    from employee_salary
                    where dept_id = 1

)
;

select d.*
from employee_demographics d
left join employee_salary s
on d.employee_id=s.employee_id
where dept_id = 1;

select employee_id
from employee_salary
where dept_id = 1;

-- using subquery in select statement
select first_name, last_name, salary, avg(salary)
from employee_salary
group by 
first_name, last_name, salary; -- won't work

select first_name, last_name, salary, 
(select avg(salary) from employee_salary) as avg_salary
from employee_salary;

-- using subquery in from statement

select gender, avg(age), max(age), min(age), count(age)
from employee_demographics
group by gender;


select gender, avg(`max(age)`) as agg_table
from
(select gender, avg(age), max(age), min(age), count(age)
from employee_demographics
group by gender) as agg_table
group by gender;

select avg(`max(age)`) 
from
(select gender, avg(age), max(age), min(age), count(age)
from employee_demographics
group by gender) as agg_table
;

select avg(max_age) as avg_max_age
from
(select gender, avg(age) as avg_age, max(age) as max_age, min(age) as min_age, count(age)
from employee_demographics
group by gender) as agg_table
;

-- WINDOW FUNCTIONS

select gender, avg(salary) as avg_salary 
from employee_demographics d
join employee_salary s
	on d.employee_id = s.employee_id
group by gender;

-- not same as 

select d.first_name, d.last_name, gender, avg(salary) over(partition by gender)
from employee_demographics d
join employee_salary s
	on d.employee_id = s.employee_id
;

select d.first_name, d.last_name, gender, sum(salary) over(partition by gender)
from employee_demographics d
join employee_salary s
	on d.employee_id = s.employee_id
;

-- rolling total
select d.first_name, d.last_name, gender, salary,
 sum(salary) over(partition by gender order by d.employee_id) as rolling_total
from employee_demographics d
join employee_salary s
	on d.employee_id = s.employee_id
;

select d.first_name, d.last_name, gender, salary,
 sum(salary) over(partition by gender order by d.age) as rolling_total
from employee_demographics d
join employee_salary s
	on d.employee_id = s.employee_id
;

select d.first_name, d.last_name, gender, salary, d.employee_id,
row_number() over()
from employee_demographics d
join employee_salary s
	on d.employee_id = s.employee_id
;

-- the row number above will not repeat itself but will do so if you include a partition

select d.first_name, d.last_name, gender, salary, d.employee_id,
row_number() over(partition by gender order by salary desc)
from employee_demographics d
join employee_salary s
	on d.employee_id = s.employee_id
;

-- rank repeats when it encounters a duplicate based off the order by and the next number will be the number positionally

select d.first_name, d.last_name, gender, salary, d.employee_id,
row_number() over(partition by gender order by salary desc) as row_num,
rank() over(partition by gender order by salary desc) as rank_num
from employee_demographics d
join employee_salary s
	on d.employee_id = s.employee_id
;


-- dense rank, duplicates but follows the number numerically

select d.first_name, d.last_name, gender, salary, d.employee_id,
row_number() over(partition by gender order by salary desc) as row_num,
rank() over(partition by gender order by salary desc) as rank_num,
dense_rank() over(partition by gender order by salary desc) as dense_rank_num
from employee_demographics d
join employee_salary s
	on d.employee_id = s.employee_id
;
















