--  To import CSV, create a table that shows corresponding headers for each row

CREATE TABLE product (
    productID INT PRIMARY KEY,
    productName VARCHAR(255),
    brand VARCHAR(255),
    model VARCHAR(255),
    type VARCHAR(255),
    size INT,
    price DECIMAL(10, 2),
    description TEXT,
    warrantyPeriod INT
);

CREATE TABLE staff (
    staffID INT PRIMARY KEY,
    firstName VARCHAR(255),
    lastName VARCHAR(255),
    position VARCHAR(100),
    contactNumber VARCHAR(20),
    email VARCHAR(100)
);


CREATE TABLE customer (
    customerID INT PRIMARY KEY,
    firstName VARCHAR(255),
    lastName VARCHAR(255),
    emailAddress VARCHAR(100),
    address TEXT,
    phoneNumber VARCHAR(20)
);

CREATE TABLE sales (
    transactionID INT PRIMARY KEY,
    productID INT,
    customerID INT,
    staffID INT,
    quantity INT,
    sellingPrice DECIMAL(10, 2),
    discount DECIMAL(5, 2),
    totalPrice DECIMAL(12, 2),
    paymentMethod VARCHAR(50),
    date DATE,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

select *
from customer;

select *
from product;

select firstname, lastname, emailaddress
from customer
limit 10;

select distinct(model)
from product;

select distinct(brand)
from product;

select brand, size, warrantyperiod
from product
where size > 50 and warrantyperiod >=2;

select productid, transactionid, paymentmethod, customerid, quantity, totalprice
from sales
where paymentmethod ilike 'bank deposit';

select * from sales;

select *
from sales 
where staffid = 501 or staffid= 505;

select *
from sales 
where staffid IN (501,505);


select count(*), staffid
from sales
where staffid = 501 or staffid=505
group by staffid;

select sum("quantity" * "sellingprice"), staffid
from sales
group by staffid
having sum(totalprice) > 900000;


select sum(totalprice), staffid
from sales
group by staffid
having sum(totalprice) > 900000;


select min(quantity)
from sales;

select max(sellingprice)
from sales;

select 'brand', AVG(warrantyperiod)
from product
group by brand
having avg(warrantyperiod) > 1;


select sum(quantity) as "Total Quantity Sold", productid
from sales
group by productid
order by sum(quantity) DESC
limit 5;

select *
from sales
where totalprice between 5000 and 10000;


select round(sum(totalprice),0)
from sales;

select *
from product
where description ILIKE '%dolby%';



SELECT transactionid, productid,customerid, quantity, totalprice
FROM sales
WHERE paymentmethod ilike 'bank deposit';

select productid, transactionid, paymentmethod, customerid, quantity, totalprice
from sales
where paymentmethod ilike 'bank deposit';
