select *
FROM orderdetails;

SELECT *
FROM customers;

SELECT *
FROM orders;

SELECT distinct(orderid)
from orders;

SELECT *
FROM employees;

SELECT *
FROM categories;

SELECT *
FROM products;

SELECT *
FROM shippers;

SELECT *
FROM suppliers;


SELECT customers.customerid, COUNT(orderid) AS Total_orders
    FROM customers
    INNER JOIN orders ON orders.customerid = customers.customerid
    GROUP BY customers.customerid;
	
SELECT SUM(CustomerOrders.Total_orders) AS Total_Orders
FROM (
    SELECT customers.customerid, COUNT(orderid) AS Total_orders
    FROM customers
    INNER JOIN orders ON orders.customerid = customers.customerid
    GROUP BY customers.customerid
)AS CustomerOrders;


-- display all products alongside supplier NAMES

SELECT products.productname, suppliers.suppliername
FROM products
INNER JOIN suppliers on products.supplierid = suppliers.supplierid;

SELECT distinct(count(products.productname)) AS Products_owned, suppliers.suppliername
FROM products
INNER JOIN suppliers on products.supplierid = suppliers.supplierid
GROUP BY suppliers.suppliername;

SELECT SUM(Total_products.Total_sum) AS Total_sum
FROM   (SELECT distinct(count(products.productname)) as Total_sum, suppliers.suppliername
		FROM products
		INNER JOIN suppliers on products.supplierid = suppliers.supplierid
		GROUP BY suppliers.suppliername
) as Total_products;

-- LEFT JOIN
SELECT customers.customerid, customers.customername, orders.orderid
FROM customers
LEFT JOIN orders ON orders.customerid = customers.customerid;

SELECT products.productname, orderdetails.orderid
FROM products
LEFT JOIN orderdetails on orderdetails.productid = products.productid;

-- RIGHT JOIN
SELECT orders.orderid, shippers.shippername
FROM orders
RIGHT JOIN shippers on orders.shipperid = shippers.shipperid;

SELECT count(orders.orderid), shippers.shippername
FROM shippers
RIGHT JOIN orders on orders.shipperid = shippers.shipperid
GROUP BY shippers.shippername;


SELECT categories.categoryname, products.productname
FROM categories
LEFT JOIN products ON products.categoryid = categories.categoryid;


-- FULL JOINS
SELECT employees.lastname, employees.firstname, orders.orderid
FROM employees
LEFT JOIN orders on orders.employeeid = employees.employeeid;

SELECT employees.lastname, employees.firstname, orders.orderid
FROM employees
FULL JOIN orders on orders.employeeid = employees.employeeid;
