-- Question 1
SELECT "ProductCategory",
       SUM(CASE
               WHEN "Price" > 100 THEN "Price" * 0.9 * "Quantity"
               WHEN "Price" BETWEEN 50 AND 100 THEN "Price" * 0.95 * "Quantity"
               ELSE "Price" * "Quantity"
           END) as "Discounted Revenue"
FROM orders
JOIN products ON orders."ProductID" = products."ProductID"
GROUP BY "ProductCategory";

-- Question 2
SELECT SUM(COALESCE(products."Price", 10) * orders."Quantity") as "Total Revenue"
FROM orders
JOIN products ON orders."ProductID" = products."ProductID";

-- Question 3
SELECT COUNT(DISTINCT "OrderID") as "Number of Orders in 2015"
FROM orders
WHERE CAST("OrderDate" AS DATE) BETWEEN '2015-01-01' AND '2015-12-31';

-- Question 4
SELECT p."ProductName", p."ProductCategory", SUM(o."Quantity") as "Total Quantity Sold"
FROM orders o
JOIN products p ON o."ProductID" = p."ProductID"
WHERE o."OrderDate" BETWEEN '2015-01-01' AND '2015-12-31'
GROUP BY p."ProductName", p."ProductCategory"
ORDER BY "Total Quantity Sold" DESC
LIMIT 1;

-- Question 5
SELECT 
    COALESCE(
        CAST(AVG(p."Price") AS TEXT),
        'All products were ordered'
    ) as "Result"
FROM products p
WHERE p."ProductID" NOT IN (
    SELECT DISTINCT o."ProductID" FROM orders o
);
