-- Determine the average sale amount for each product category.
SELECT dimproduct.Category, AVG(factsales.SaleAmount) AS AverageSaleAmount
FROM DimProduct
INNER JOIN FactSales ON dimproduct.ProductID = factsales.ProductID
GROUP BY dimproduct.Category;

-- List customers and their purchase counts who have bought more than 3 items.
SELECT dimcustomer.FirstName, dimcustomer.LastName, COUNT(factsales.SaleID) AS NumberOfPurchases
FROM DimCustomer
INNER JOIN FactSales ON dimcustomer.CustomerID = factsales.CustomerID
GROUP BY dimcustomer.CustomerID
HAVING COUNT(factsales.SaleID) > 3;

-- List all products and any sales data, including products that have not been sold and sales without a linked product.
SELECT dimproduct.ProductName, factsales.SaleID, factsales.SaleAmount
FROM DimProduct 
FULL OUTER JOIN FactSales ON dimproduct.ProductID = factsales.ProductID;

-- Show all customers and any sales transactions, including customers with no purchases.
SELECT dimcustomer.FirstName, dimcustomer.LastName, factsales.SaleID
FROM DimCustomer
FULL OUTER JOIN FactSales ON dimcustomer.CustomerID = factsales.CustomerID;

-- Find total sales and stock quantities for all products, including those never sold.
SELECT dimproduct.ProductName, SUM(factsales.QuantitySold) AS TotalSold, dimproduct.StockQuantity
FROM DimProduct
FULL OUTER JOIN FactSales ON dimproduct.ProductID = factsales.ProductID
GROUP BY dimproduct.ProductName, dimproduct.StockQuantity;

--List all sales transactions and match them with product information, including sales with unlisted products.
SELECT factsales.SaleID, dimproduct.ProductName, dimproduct.Price
FROM FactSales
RIGHT JOIN DimProduct ON factsales.ProductID = dimproduct.ProductID;

--Show every product and its last sale date, including products that have never been sold.
SELECT dimproduct.ProductName, MAX(factsales.SaleDate) AS LastSaleDate
FROM DimProduct
RIGHT JOIN FactSales ON dimproduct.ProductID = factsales.ProductID
GROUP BY dimproduct.ProductName;

--Show all products along with any customers who have purchased them, including products that have not been purchased by any customer.
SELECT dp.ProductName, dc.FirstName, dc.LastName
FROM DimProduct dp
LEFT JOIN FactSales fs ON dp.ProductID = fs.ProductID
LEFT JOIN DimCustomer dc ON fs.CustomerID = dc.CustomerID;

--Identify products that have never been sold.
SELECT dp.ProductName
FROM DimProduct dp
LEFT JOIN FactSales fs ON dp.ProductID = fs.ProductID
WHERE fs.SaleID IS NULL;

--Find customers who have not made any purchases.
SELECT dc.FirstName, dc.LastName
FROM DimCustomer dc
LEFT JOIN FactSales fs ON dc.CustomerID = fs.CustomerID
WHERE fs.SaleID IS NULL;

