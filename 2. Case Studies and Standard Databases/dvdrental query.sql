select *
from actor;

ALTER TABLE actor
ADD COLUMN full_name TEXT;

UPDATE actor
SET full_name = first_name || ' ' || last_name;


select *
from address;

select *
from city;

select *
from country;

select *
from category;

select *
from customer;

select *
from film;

select *
from film_actor;

select *
from film_category;

select *
from inventory;

select *
from language;

select *
from payment;

select *
from rental;

select *
from staff;

select *
from store;

-- Q1
-- Retrieve the top 5 customers by the total amount 
-- they spent, including their names and the total amount.

ALTER TABLE customer
ADD COLUMN full_name TEXT;

UPDATE customer
SET full_name = first_name || ' ' || last_name;




select c.full_name, sum(amount)
from payment p
inner join customer c on c.customer_id = p.customer_id
group by c.customer_id, c.full_name
order by sum(amount) desc 
limit 5;

-- Rank films based on their rental count and 
-- display the top 10 most rented films with their rank.

select f.film_id, f.title, count(r.rental_id),
rank() over (order by count(r.rental_id) desc) as rental_rank,
dense_rank() over (order by count(r.rental_id) desc) as dense_rental_rank
from film f
inner join inventory i ON i.film_id = f.film_id
inner join rental r ON r.inventory_id = i.inventory_id
group by f.film_id, f.title
order by count(r.rental_id) desc
limit 10;

-- Create a view called customer_rentals that 
-- shows each customer’s full name and the number 
-- of films they have rented.

create view customer_rentals as
select c.full_name, count(r.rental_id)
from customer c
inner join rental r on r.customer_id = c.customer_id
group by c.full_name, c.customer_id;

select *
from customer_rentals
order by count desc;

create view customer_rentalss as
select c.full_name, count(r.rental_id) as total_rentals
from customer c
inner join rental r on r.customer_id = c.customer_id
group by c.full_name;

select *
from customer_rentalss
order by total_rentals desc;

create view customer_rentalsss as
select c.full_name, count(r.rental_id) as total_rentals
from customer c
left join rental r on r.customer_id = c.customer_id
group by c.full_name;

select *
from customer_rentalsss
order by total_rentals desc;


DROP VIEW IF EXISTS customer_rentalsss, customer_rentals,customer_rentalss CASCADE;


-- Using a subquery, find the category of films
-- that has the highest total rental income.

select category_id,  income
from (
select f.category_id, sum(p.amount) as income
from rental r
inner join inventory i on i.inventory_id = r.inventory_id
inner join film_category f on f.film_id = i.film_id
inner join payment p on p.rental_id = r.rental_id
group by f.category_id) as category_totals
order by income desc
limit 1;


-- Use CASE WHEN to categorize films into ‘Short,’ 
-- ‘Medium,’ and ‘Long’ based on their length

select film_id, title, length,
case
	when length > 90 then 'long'
	when length > 60 then 'medium'			
	else 'short'						
end as length_category
from film ;

-- Find the top 3 actors who have appeared in the most 
-- films and their total film count

select a.full_name, count(film_id) 
from actor a
inner join film_actor on film_actor.actor_id = a.actor_id
group by a.full_name, a.actor_id
order by count(film_id) desc
limit 3;

-- For each customer, calculate their average rental 
-- duration in days and identify those with an average 
-- rental duration of more than 5 days.

select avg(return_date - rental_date)
from rental

select c.full_name, c.customer_id, avg(return_date - rental_date) as avg_return_day
from customer c
inner join rental on rental.customer_id = c.customer_id
group by c.full_name, c.customer_id
having avg(return_date - rental_date) > interval '5 days 23:59:59';

SELECT 
  c.full_name, 
  c.customer_id, 
  FLOOR(EXTRACT(EPOCH FROM avg(return_date - rental_date)) / 86400) AS avg_return_day
FROM customer c
INNER JOIN rental ON rental.customer_id = c.customer_id
GROUP BY c.full_name, c.customer_id
HAVING 
  FLOOR(EXTRACT(EPOCH FROM avg(return_date - rental_date)) / 86400) > 5;

  select c.full_name, c.customer_id, round(avg(rental_duration),0) as avg_return_day
from customer c
inner join inventory i on i.store_id = c.store_id
inner join film f on f.film_id = i.film_id
group by c.full_name, c.customer_id
having round(avg(rental_duration),0) > 5
;

-- Identify the top 3 stores based on total rental
-- transactions.

select s.store_id, count(rental_id)
from store s
inner join inventory on inventory.store_id = s.store_id
inner join rental r on r.inventory_id = inventory.inventory_id
group by s.store_id
order by count(rental_id) desc
limit 3;


-- Find the top 5 films that generated the highest total 
-- revenue and display their titles, rental counts, 
-- and total income.


SELECT 
  f.film_id, 
  f.title, 
  COUNT(p.payment_id) AS rental_count, 
  SUM(p.amount) AS total_revenue
FROM film f
INNER JOIN inventory i ON i.film_id = f.film_id
INNER JOIN rental r ON r.inventory_id = i.inventory_id
INNER JOIN payment p ON p.rental_id = r.rental_id
GROUP BY f.film_id, f.title
ORDER BY total_revenue DESC
LIMIT 5;


-- Use a subquery to list customers who have rented 
-- more than the average number of rentals per customer.

SELECT full_name, COUNT(r.rental_id) AS rentals
FROM customer c
INNER JOIN rental r ON r.customer_id = c.customer_id
GROUP BY full_name, c.customer_id
HAVING COUNT(r.rental_id) > (
  SELECT AVG(rental_count)
  FROM (
    SELECT COUNT(rental_id) AS rental_count
    FROM rental
    GROUP BY customer_id
  ) AS customer_rental_counts
);

-- For each film category, calculate the average rental 
-- duration (in days) and sort them from highest to lowest
-- average rental duration.

SELECT 
  fc.category_id, 
  c.name AS category_name,
  AVG(return_date - rental_date) AS avg_rental_duration
FROM film_category fc
INNER JOIN inventory i ON i.film_id = fc.film_id
INNER JOIN rental r ON r.inventory_id = i.inventory_id
INNER JOIN category c ON c.category_id = fc.category_id
GROUP BY fc.category_id, c.name
ORDER BY avg_rental_duration DESC;

select category_id, avg(return_date - rental_date)
from film_category
inner join inventory on inventory.film_id = film_category.film_id
inner join rental on rental.inventory_id = inventory.inventory_id
group by category_id
order by avg(return_date - rental_date) desc;

