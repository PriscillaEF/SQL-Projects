--1
SELECT Category, ProductName, Price,
       CASE
           WHEN Price < 100 THEN 'Low'
           WHEN Price BETWEEN 100 AND 500 THEN 'Medium'
           WHEN Price > 500 THEN 'High'
           ELSE 'Unknown'
       END AS PriceRange
FROM DimProduct;

--2
SELECT ProductID, ProductName, COALESCE(StockQuantity, 0) AS StockQuantity
FROM DimProduct;

--3
SELECT CustomerID, FirstName, LastName, CAST(SUM(QuantitySold) AS INT) AS TotalProductsPurchased
FROM FactSales
JOIN DimCustomer ON FactSales.CustomerID = DimCustomer.CustomerID
GROUP BY FactSales.CustomerID;

--4
SELECT ProductID, ProductName,
       COALESCE((SELECT SUM(QuantitySold) FROM FactSales 
				 WHERE FactSales.ProductID = DimProduct.ProductID 
				 AND SaleDate > CURRENT_DATE - INTERVAL '1 year'), 0) AS SalesLastYear
FROM DimProduct
HAVING SalesLastYear = 0;

--5
UPDATE DimProduct
SET Price = CASE
                WHEN ProductID IN (SELECT ProductID FROM FactSales
                                    GROUP BY ProductID
                                    HAVING SUM(QuantitySold) < 50) THEN Price * 0.9
                ELSE Price
            END;

--6
SELECT ProductID, 
       COALESCE(CAST(AVG(SaleAmount) AS DECIMAL(10,2)), 0.00) AS AvgSaleAmount
FROM FactSales
GROUP BY ProductID;


