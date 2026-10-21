--  STRING FUNCTIONS

select length('skyfall');

select first_name, length(first_name)
from employee_demographics
order by 2;

select upper('sky');
select lower('sky');

select first_name, upper(first_name)
from employee_demographics
order by 2;

-- TRIM (LEFT TRIM, RIGHT TRIM) - remove leading and trailing spaces 

Select trim('r     sky     ');

Select replace('r     sky     ',' ', '');

Select trim('     sky     ');

Select ltrim('     sky     ');

Select rtrim('     sky     ');


-- SUBSTRING

-- left and right

select first_name, left(first_name, 4)
from employee_demographics;

select first_name, 
left(first_name, 4),
right(first_name, 4),
substring(first_name, 3, 2),
birth_date,
substring(birth_date, 6, 2) as birth_month
from employee_demographics;


-- replace (replace specific characters with a different character you want

select first_name, replace(first_name, 'a', 'z')
from employee_demographics
;

-- locate

select locate('x', 'Alexander')
;

select first_name, locate('An',first_name)
from employee_demographics
;

select first_name, last_name,
concat(first_name,' ', last_name)
from employee_demographics;


select 
concat(first_name,' ', last_name) as full_name
from employee_demographics;

-- CASE STATEMENTS

select first_name, 
last_name,
age,
Case
	when age <= 30 then 'Young'
    when age between 31 and 50 then 'old'
    when age >= 50 then "on death's door"
End as Age_bracket
from employee_demographics;

-- pay increase and bonus
-- < 50000 = 5%
-- > 50000 = 7%
-- finance = 10%

-- select first_name, 
-- last_name, salary,
-- case
-- 	when salary < 50000 then salary * (1 + 0.05)
-- end
-- from employee_salary;

select first_name, 
last_name, salary,
case
	when salary < 50000 then salary + (salary * 0.05)
    when salary > 50000 then salary + (salary * 0.07)
end as New_salary,
case
	when dept_id=6 then salary * .10
end as bonus
from employee_salary;












