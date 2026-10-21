select * from categories;

select * from customers;

select * from employees;


-- show categoryid and category name from categories

select categoryid, categoryname
from categories;

-- customername and contactname from customers
SELECT customerid, customername, contactname
FROM customers;

--return orderid, productid and quantity from orderdetails TABLE
SELECT orderid, productid, quantity
FROM orderdetails;


-- where: used to filter your output based on conditions
SELECT orderid, productid, quantity
FROM orderdetails
WHERE quantity > 20;

-- return orders from a particular customer

SELECT *
FROM orders
where customerid = 5;

-- order by : used for rearranging output based on the values in the column

SELECT orderid, productid, quantity
FROM orderdetails
WHERE quantity > 20
ORDER BY quantity DESC;

-- Limit : used to restrict the number of rows returned

SELECT orderid, productid, quantity
FROM orderdetails
WHERE quantity > 20
ORDER BY quantity DESC
LIMIT 10;

select *
from products
order by price DESC
limit 5;

SELECT * 
FROM suppliers
limit 5;

-- between : used in conjunction with where to filter based on conditions within a specific range

SELECT *
FROM employees
WHERE birthdate BETWEEN '1950-01-01 ' and '1960-12-31';

-- LIKE : used with where to return values that look like what you have specified
--starts with A

SELECT employeeid, firstname, lastname
FROM employees
WHERE firstname LIKE 'A%';


--ends with A

SELECT employeeid, firstname, lastname
FROM employees
WHERE firstname LIKE '%a';


--A between

SELECT employeeid, firstname, lastname
FROM employees
WHERE firstname LIKE '%a%';


-- in/not in : used to specify values that are to be included or excluded

SELECT *
FROM orders;

SELECT *
FROM orders
WHERE shipperid in (1,3);

-- not in

SELECT *
FROM orders
WHERE shipperid not in (1,3);

-- AGGREGATION FUNCTIONS (SUM,AVERAGE,COUNT)

SELECT *
from orderdetails; 

SELECT orderdetails.orderid, sum(quantity)
from orderdetails
group by orderdetails.orderid;


-- HAVING : USED FOR FILTERING OUTPUTS THAT HAVE AGGREGATES IN PLACE OF WHERE

SELECT orderdetails.orderid, sum(quantity)
from orderdetails
group by orderdetails.orderid
HAVING SUM(QUANTITY)>50;

SELECT *
from products;

SELECT *
from categories;

SELECT categoryid, count(*) AS "Total Products"
from products
group by categoryid
HAVING count(*) > 10;


-- distinct
SELECT distinct(country)
from customers;