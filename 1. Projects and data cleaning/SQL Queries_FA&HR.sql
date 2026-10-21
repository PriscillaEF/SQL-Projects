-- 5 Retrieve the transactions with product details and the respective staff details.
-- Sales X Product X Staff Table ----> Taiwo

SELECT s.transaction_id,
		s.total_price,
		s.quantity,
		p.*,
		st.staff_id,
		st.first_name,
		st.last_name
FROM sales AS s
INNER JOIN product AS p
ON s.product_id = p.product_id
JOIN staff st
ON st.staff_id = s.staff_id;

SELECT *
FROM sales AS s
INNER JOIN product AS p
ON s.product_id = p.product_id
JOIN staff st
ON st.staff_id = s.staff_id;

-- Class  * Exam 


--7. List all sales transactions and the associated customer details.
-- Sales X Customer
SELECT s.*, c.*
FROM sales s
INNER JOIN customer c
ON s.customer_id = c.customer_id;

-- 8. Retrieve sales transactions and the associated customer details for credit card payment method.
SELECT s.*, c.first_name, c.last_name
FROM customer c
JOIN sales s
ON s.customer_id = c.customer_id
WHERE s.payment_method = 'credit card';


-- 10. Find the total transactions processed and total revenue by staff 501 and 505. Include the staff first name, last 
-- name and email address
SELECT
    st.staff_id,
    st.first_name,
    st.last_name,
    st.email,
    COUNT(s.transaction_id) AS total_transactions,
    SUM(s.total_price) AS total_revenue
FROM
    staff st
JOIN
    sales s ON st.staff_id = s.staff_id
WHERE
    st.staff_id IN (501, 505)
GROUP BY
    st.staff_id, st.first_name, st.last_name, st.email;