-- 1. Show all details about orders, products and properties.
SELECT *
FROM orders;

SELECT *
FROM products;

SELECT * 
FROM propertyinfo;

-- 2. In what Cities and States are Dennis Properties Located.
select "PropertyCity", "PropertyState"
from propertyinfo;

-- 3. What are the different product categories Dennis has in his store?
SELECT DISTINCT "ProductCategory"
FROM products;

-- 4. What are the numbers of products in each product category?
SELECT "ProductCategory", COUNT(*)
FROM products
GROUP BY "ProductCategory";

SELECT "ProductCategory", COUNT("ProductName")
FROM products
GROUP BY "ProductCategory";

-- 5. What is the total quantity of products ordered?
select sum("Quantity") as "Total Quantity Ordered"
from orders;

-- 6. What are the five most expensive products?
SELECT "ProductName", "Price"
FROM products
ORDER BY "Price" DESC
LIMIT 5;

-- 7. What is the average price of products in each category?
select "ProductCategory", ROUND(AVG("Price"),1) AS "Average Price"   
from products
group by "ProductCategory";

-- ROUND(Column, 2)

-- 8. Which property has ordered the most quantity of products?
select "PropertyID", sum("Quantity") AS "Total Quantity"
from orders 
group by "PropertyID"
order by sum("Quantity") Desc;


-- 9. What products have names starting with “T”?
SELECT "ProductName"
FROM products
WHERE "ProductName" LIKE 'T%';

-- 10. Lists all products with names containing paper.
SELECT "ProductName"
FROM products
WHERE lower("ProductName") LIKE '%paper%';

SELECT "ProductName"
FROM products
WHERE "ProductName" ILIKE '%paper%';

-- 11. Extract the name and category of products whose prices are above $200
select "ProductName", "ProductCategory", "Price"
from products
where "Price" > 200;

-- 12. What is the total quantity of products ordered in 2015 and 2016
-- respectively?
SELECT SUM("Quantity") AS "Total Quantity Ordered"
FROM orders
WHERE "OrderDate" BETWEEN '2015-01-01' AND '2015-12-31';

-- Similar Query
SELECT SUM("Quantity") AS "Total Quantity Ordered"
FROM orders
WHERE EXTRACT(YEAR FROM "OrderDate" :: date) = 2015;

SELECT SUM("Quantity") AS "Total Quantity Ordered"
FROM orders
WHERE "OrderDate" BETWEEN '2016-01-01' AND '2016-12-31';

-- 13. Which orders were made by property 1, 10, and 20?
SELECT "OrderID", "PropertyID"
FROM orders
WHERE "PropertyID" IN (1,10,20);

-- 14. What is the least expensive product?
SELECT "ProductName", "Price"
FROM products
ORDER BY "Price"
LIMIT 3;

select min ("Price"), "ProductName"
from products
group by "ProductName"
order by min("Price") 
limit 3;

-- 15. Identify whether a product’s worth is more than $200 or not in a new
-- column called 'Price Category’
SELECT "ProductName", "Price",
CASE
	WHEN "Price" > 200 THEN 'The price of the product is more than $200'
	WHEN "Price" < 200 THEN 'The price of the product is not up to $200'
END AS "Price Category"
FROM products;