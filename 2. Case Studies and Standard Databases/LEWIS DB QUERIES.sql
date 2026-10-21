-- Q1
--  How much revenue did we generate from each product category, after considering a 10% discount 
-- for products that cost more than $100, and a 5% discount for products that cost between $50 and 
-- $100? 

SELECT * 
FROM products;

SELECT * 
FROM orders;

SELECT * 
FROM propertyinfo;

SELECT "ProductCategory", 
		SUM(CASE
				WHEN "Price" > 100 THEN (("Price" - (0.1 * "Price")) * "Quantity")
				WHEN "Price" BETWEEN 50 and 100 THEN (("Price" - (0.05 * "Price")) * "Quantity")
				ELSE "Price" * "Quantity"
			END)as "Discounted Revenue"
FROM orders
INNER JOIN products on products."ProductID" = orders."ProductID"
GROUP BY "ProductCategory";

-- Q2
-- What is the total revenue generated, considering that products with a NULL price should be 
-- treated as having a default price of $10?

SELECT "ProductName",
		SUM(COALESCE("Price", 10) * "Quantity") as "C Revenue"
FROM orders
INNER JOIN products on products."ProductID" = orders."ProductID"
GROUP BY "ProductName";

SELECT SUM(COALESCE("Price", 10) * "Quantity") as "Total Revenue"
FROM orders
INNER JOIN products on products."ProductID" = orders."ProductID"
;

-- Q3
-- How many orders were placed in the year 2015?

SELECT COUNT(DISTINCT "OrderID")
FROM orders
WHERE "OrderDate" BETWEEN '2015-01-01' AND '2015-12-31';


SELECT COUNT(DISTINCT "OrderID")
FROM orders
WHERE CAST("OrderDate" as date) BETWEEN '2015-01-01' AND '2015-12-31';


-- CHECK DATA TYPE
SELECT 'OrderDate', data_type
FROM information_schema.columns
WHERE table_name = 'orders' AND column_name = 'OrderDate';

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'orders';

-- Q4
-- What is the name and category of the top-selling product 
-- (in terms of quantity) in the year 2015?

SELECT "ProductName", "ProductCategory", SUM("Quantity") AS "Total Quantity"
FROM products
INNER JOIN orders ON orders."ProductID" = products."ProductID"
WHERE "OrderDate" BETWEEN '2015-01-01' and '2015-12-31'
GROUP BY "ProductName", "ProductCategory"
ORDER BY "Total Quantity" DESC
LIMIT 1;

-- Q5
-- What is the average price of products that have never been ordered?

SELECT p."ProductID", AVG(p."Price") AS avg_price
FROM products p
WHERE p."ProductID" NOT IN 
    (SELECT o."ProductID"
     FROM orders o
     WHERE o."Quantity" IS NOT NULL)
GROUP BY p."ProductID";


SELECT COALESCE(
		Cast(avg("Price")as text), 'All Products were ordered') as "Avg"
FROM products p
WHERE p."ProductID" NOT IN 
    (SELECT DISTINCT o."ProductID"
     FROM orders o);


SELECT COALESCE(
		Cast(avg("Price")as text), 'All Products were ordered') as "Avg"
FROM products p
WHERE p."ProductID" NOT IN 
    (SELECT DISTINCT o."ProductID"
     FROM orders o);