-- data cleaning

select *
from layoffs;

-- 1. Remove duplicates
-- 2. standardize the data
-- 3. Null values or blank values
-- 4. remove unnecessary rows and columns

-- first thing we want to do is create a staging table. This is the one we will work in and clean the data. We want a table with the raw data in case something happens

create table layoff_staging
like layoffs;

select *
from layoff_staging;

insert layoff_staging
select *
from layoffs;

-- 1. Remove Duplicates

# First let's check for duplicates
select *,
row_number() over(
partition by company, industry, total_laid_off, percentage_laid_off, `date`, funds_raised_millions, location, stage,country) as row_num
from layoff_staging;

-- select *
-- from (select *,
-- row_number() over(
-- partition by company, industry, total_laid_off, percentage_laid_off, `date`, funds_raised_millions, location, stage,country) as row_num
-- from layoff_staging) as dup
-- where row_num > 1;

-- same as 

with duplicate_cte as
(
select *,
row_number() over(
partition by company, industry, total_laid_off, percentage_laid_off, `date`, funds_raised_millions, location, stage,country) as row_num
from layoff_staging
)
select *
from duplicate_cte 
where row_num > 1;

select *
from layoff_staging
where company = 'Casper';

-- with duplicate_cte as
-- (
-- select *,
-- row_number() over(
-- partition by company, industry, total_laid_off, percentage_laid_off, `date`, funds_raised_millions, location, stage,country) as row_num
-- from layoff_staging
-- )
-- delete
-- from duplicate_cte 
-- where row_num > 1;

-- the above won't work because you cannot update a CTE in MySQL
-- instead we create a new table and work with it

CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from layoff_staging2;

insert into layoff_staging2
select *,
row_number() over(
partition by company, industry, total_laid_off, percentage_laid_off, `date`, funds_raised_millions, location, stage,country) as row_num
from layoff_staging;

select *
from layoff_staging2
where row_num > 1;

delete
from layoff_staging2
where row_num > 1;

select *
from layoff_staging2;

-- 2. Standardizing Data

select company, trim(company)
from layoff_staging2;

update layoff_staging2
set company = trim(company);

select distinct(industry)
from layoff_staging2
order by 1;

select *
from layoff_staging2
where industry like 'Crypto%';
 
 update layoff_staging2
 set industry = 'Crypto'
 where industry like 'Crypto%';


select distinct(location)
from layoff_staging2
order by 1;

select distinct(country)
from layoff_staging2
where country like 'United States%'
order by 1;

select distinct country, trim(trailing '.' from country)
from layoff_staging2
where country like 'United States%'
order by 1;

-- update layoff_staging2
-- set country = 'United States'
-- where country like 'United States%';

-- select distinct(country)
-- from layoff_staging2
-- where country like 'United States%'
-- order by 1;

-- orrr

update layoff_staging2
set country = trim(trailing '.' from country)
where country like 'United States%';

select distinct country, trim(trailing '.' from country)
from layoff_staging2
order by 1;

-- Let's also fix the date columns:

-- first convert from string to date so it's in the right format
select `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoff_staging2;

update layoff_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y');

select `date`
from layoff_staging2;

-- then change to date
alter table layoff_staging2
modify column `date` date;

-- 3 WORKING WITH NULL AND BLANK VALUES

select *
from layoff_staging2
where total_laid_off is null;


select *
from layoff_staging2
where total_laid_off is null
and percentage_laid_off is null;

update layoff_staging2
set industry = Null
where industry = '';

select *
from layoff_staging2
where industry is null
or industry ='';


select *
from layoff_staging2
where company = 'Airbnb';

-- update layoff_staging2
-- set industry = 'Travel'
-- where industry = '';

select *
from layoff_staging2 t1
join layoff_staging2 t2
	on t1.company = t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

update layoff_staging2 t1
join layoff_staging2 t2
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null
and t2.industry is not null;

select *
from layoff_staging2
where company like "Bally's%";


select *
from layoff_staging2
where total_laid_off is null
and percentage_laid_off is null;

delete
from layoff_staging2
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoff_staging2
where total_laid_off is null
and percentage_laid_off is null;

-- drop the row num column

select *
from layoff_staging2;

alter table layoff_staging2
drop column row_num;

select *
from layoff_staging2;










