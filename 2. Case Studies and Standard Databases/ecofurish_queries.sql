--List all products available in the inventory.
SELECT * FROM DimProduct;

--Find the total number of customers in the database.
SELECT COUNT(*) AS TotalCustomers FROM DimCustomer;

--Display distinct categories of products sold.
SELECT DISTINCT Category FROM DimProduct;

--Identify customers who signed up in 2023.
SELECT * FROM DimCustomer WHERE signupyear = 2023

--List products priced above $500.
SELECT * FROM DimProduct WHERE Price > 500;

--Show products with less than 50 items in stock.
SELECT * FROM DimProduct WHERE StockQuantity < 50;

--List all sales transactions.
SELECT * FROM FactSales;

--Count the total number of sales transactions.
SELECT COUNT(*) AS TotalSalesTransactions FROM FactSales;

--Display the top 10 most expensive products.
SELECT * FROM DimProduct ORDER BY Price DESC LIMIT 10;

--Find the average sale amount per transaction.
SELECT AVG(SaleAmount) AS AverageSaleAmount FROM FactSales;

--Calculate the total revenue generated from sales.
SELECT SUM(SaleAmount) AS AverageSaleAmount FROM FactSales;

--Round the average price of all products to 2 decimal places.
SELECT ROUND(AVG(Price), 2) AS AveragePrice FROM DimProduct;

--Display all products with 'Eco' in the product name.
SELECT * FROM DimProduct WHERE ProductName LIKE '%Eco%';

--List the first 5 sales transactions in ascending order of SaleAmount.
SELECT * FROM FactSales ORDER BY SaleAmount ASC LIMIT 5;

--List customer emails that contain 'gmail'.
SELECT Email FROM DimCustomer WHERE Email LIKE '%gmail%';

--Display products priced between $100 and $300.
SELECT * FROM DimProduct WHERE Price BETWEEN 100 AND 300;

--Count the number of products in each category.
SELECT Category, COUNT(*) AS NumberOfProducts FROM DimProduct GROUP BY Category;

--Calculate the minimum, maximum, and average price of products.
SELECT MIN(Price) AS MinPrice, MAX(Price) AS MaxPrice, AVG(Price) AS AvgPrice FROM DimProduct;

--List all sales transactions between January 1, 2023, and December 31, 2023.
SELECT * FROM FactSales WHERE SaleDate BETWEEN '2023-01-01' AND '2023-12-31';

--Find the total quantity of products sold for each product.
SELECT ProductID, SUM(QuantitySold) AS TotalQuantitySold FROM FactSales GROUP BY ProductID;








