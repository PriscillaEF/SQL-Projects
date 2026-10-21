Create table product (
	productID int primary key,
	productname varchar(255),
	brand varchar(255),
	model varchar(255),
	type varchar(255),
	size int,
	price decimal(10,2),
	description text,
	warrantyPeriod varchar(20)
);

select * from product;

CREATE TABLE staff (
staffID INT PRIMARY KEY,
firstName VARCHAR(255),
lastName VARCHAR(255),
position VARCHAR(100),
contactNumber VARCHAR(20),
email VARCHAR(100)
);
select * from staff;

CREATE TABLE customer (
customerID INT PRIMARY KEY,
firstName VARCHAR(255),
lastName VARCHAR(255),
emailAddress VARCHAR(100),
address TEXT,
phoneNumber VARCHAR(20)
);

select * from customer;

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

select * from sales;
select * from customer;
select * from product;
select * from staff;

select sales.productid, transactionid, brand, description, quantity, totalprice, date, warrantyperiod 
from product
inner join sales on product.productid=sales.productid;

select sales.transactionid, staff.staffid,firstname,lastname,position,contactnumber,email,sales.productid, brand, description, quantity, totalprice, date, warrantyperiod
from sales
inner join staff on sales.staffid=staff.staffid
inner join product on product.productid=sales.productid;


select product.productid, transactionid, brand, description, quantity, totalprice, date, warrantyperiod 
from product
left join sales on product.productid=sales.productid;

select customer.customerid, firstname, lastname, emailaddress, phonenumber, transactionid,quantity, totalprice, date
from sales
right join customer on customer.customerid=sales.customerid;

select product.productid, transactionid, brand, description, quantity, totalprice, date, warrantyperiod 
from product
full outer join sales on product.productid=sales.productid;



-- a. Retrieve the product details and the corresponding staff information for each sale made.



-- b. Find the names and contact information of the staff members who were involved in each sale along
-- with the product details.
-- c. Retrieve the product and customer details for each sale made, including the transaction ID and date
-- of sale.
-- d. Get the product details and the related customer information for each sale, including the transaction
-- ID and payment method.
-- e. Fetch the product and sales information, including the selling price and quantity sold for each
-- transaction.
-- f. Retrieve the product details and the corresponding customer information for each sale made,
-- including the transaction ID and date of sale.

