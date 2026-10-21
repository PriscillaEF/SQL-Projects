-- 1
SELECT Category, 
       round(AVG(Price), 2)AS AveragePrice, 
       MIN(Price) AS MinPrice, 
       MAX(Price) AS MaxPrice
FROM DimProduct
GROUP BY Category
ORDER BY AveragePrice;

--2 
SELECT ProductName, Category, StockQuantity
FROM DimProduct
WHERE COALESCE(StockQuantity, 0) <= 1 -- Assuming 1 as a low-stock threshold
ORDER BY StockQuantity ASC;

--3
SELECT dc.CustomerID, dc.FirstName, dc.LastName, SUM(fs.QuantitySold) AS TotalQuantity
FROM FactSales fs
JOIN DimCustomer dc ON fs.CustomerID = dc.CustomerID
GROUP BY dc.CustomerID
ORDER BY TotalQuantity DESC;

--4
SELECT dp.ProductName, dp.Category, 
      SUM(fs.QuantitySold) AS QuantitySoldLastYear
FROM DimProduct dp
LEFT JOIN FactSales fs ON dp.ProductID = fs.ProductID
AND fs.Saleyear = 2023 
GROUP BY dp.Category, dp.ProductName
HAVING  SUM(fs.QuantitySold) <= 5; -- Assuming the quantitysold to be those less than 5

--5
SELECT SaleMonth, Category, TotalSold
FROM (
    SELECT 
        EXTRACT(MONTH FROM fs.SaleDate) AS SaleMonth, 
        dp.Category, 
        SUM(fs.QuantitySold) AS TotalSold
    FROM FactSales fs
    JOIN DimProduct dp ON fs.ProductID = dp.ProductID
    GROUP BY EXTRACT(MONTH FROM fs.SaleDate), dp.Category
) AS MonthlyCategorySales
ORDER BY SaleMonth, TotalSold DESC;




