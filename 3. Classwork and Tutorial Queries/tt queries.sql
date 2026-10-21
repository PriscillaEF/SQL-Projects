-- a)
SELECT ProductID, SUM(inventoryQuantity) AS Total_Units_Sold
FROM Sales
GROUP BY ProductID;

-- b)
SELECT p.ProductCategory, SUM(s.inventoryquantity) AS Sales_Volume
FROM Sales s 
JOIN Product p ON p.productid = s.productid
WHERE EXTRACT(YEAR FROM SalesDate) = '2021' AND EXTRACT(MONTH FROM SalesDate) = '3'
GROUP BY ProductCategory
ORDER BY Sales_Volume DESC
LIMIT 1;

-- c)
SELECT s.sales_Month, s.sales_Year, AVG(f.inflationrate) AS Average_Inflation, SUM(s.inventoryQuantity) AS Total_Sales
FROM Sales s 
JOIN factors f ON f.salesdate = s.salesdate
GROUP BY sales_Year, sales_Month;

-- d)
SELECT s.sales_Year, s.sales_Month, AVG(f.InflationRate) AS Avg_Inflation_Rate, SUM(s.inventoryQuantity) AS Total_Sales_Quantity
FROM Sales s
JOIN factors f ON f.salesdate = s.salesdate
WHERE s.SalesDate >= (CURRENT_DATE - INTERVAL '1 year')
GROUP BY sales_Year, sales_Month
ORDER BY sales_Year, sales_Month;

-- e)
SELECT s.ProductID, ROUND(AVG(s.inventoryQuantity)) AS Average_Sales_Without_Promotion, p.promotions
FROM Sales s
JOIN Product p ON p.productid = s.productid
WHERE Promotions = 'No'
GROUP BY S.ProductID,  p.promotions

UNION ALL

SELECT s.ProductID, ROUND(AVG(s.inventoryQuantity)) AS Average_Sales_Without_Promotion,  p.promotions
FROM Sales s
JOIN Product p ON p.productid = s.productid
WHERE Promotions = 'Yes'
GROUP BY s.ProductID,  p.promotions;

-- f)
SELECT ProductCategory, ROUND(AVG(inventoryQuantity),2) AS Average_Sales
FROM Sales s JOIN Product p ON p.productid = s.productid
GROUP BY ProductCategory;

-- g)
SELECT Sales_Year, SUM(GDP) AS Total_GDP, SUM(inventoryQuantity) AS Total_Sales
FROM Sales s
JOIN factors f ON f.salesdate = s.salesdate
GROUP BY sales_Year;

-- h)
SELECT ProductID, SUM(InventoryQuantity) AS Total_Units_Sold
FROM Sales 
GROUP BY ProductID
ORDER BY Total_Units_Sold DESC
LIMIT 10;

-- i)
SELECT p.ProductCategory, AVG(f.SeasonalFactor) AS Average_Seasonal_Factor, SUM(s.inventoryQuantity) AS Total_Sales
FROM Sales s
JOIN Product p ON p.productid = s.productid
JOIN factors f ON f.salesdate = s.salesdate
GROUP BY ProductCategory;

-- j)
SELECT 
    p.ProductCategory, 
    AVG(s.inventoryQuantity) AS Average_Sales_Quantity,
    COUNT(CASE WHEN p.Promotions = 'Yes' THEN 1 END) AS Promotion_Count
FROM Sales s
JOIN Product p ON s.ProductID = p.ProductID
GROUP BY p.ProductCategory
ORDER BY Average_Sales_Quantity DESC;


