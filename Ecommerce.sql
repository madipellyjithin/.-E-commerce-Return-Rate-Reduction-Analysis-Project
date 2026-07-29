CREATE DATABASE ecommerce;
USE ecommerce;
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    country VARCHAR(50),
    marketing_channel VARCHAR(50)
);
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50)
);
CREATE TABLE Returns (
    return_id INT PRIMARY KEY,
    order_id INT,
    return_reason VARCHAR(100),
    return_date DATE
);
INSERT INTO Products VALUES
(101,'Laptop','Electronics'),
(102,'Phone','Electronics'),
(103,'Shoes','Fashion'),
(104,'T-Shirt','Fashion'),
(105,'Chair','Furniture');
INSERT INTO Orders VALUES
(1,501,101,'2025-01-01','USA','Google'),
(2,502,102,'2025-01-02','USA','Facebook'),
(3,503,103,'2025-01-03','Canada','Instagram'),
(4,504,104,'2025-01-04','Canada','Google'),
(5,505,105,'2025-01-05','UK','Email'),
(6,506,101,'2025-01-06','USA','Instagram'),
(7,507,103,'2025-01-07','UK','Facebook'),
(8,508,102,'2025-01-08','USA','Email');
INSERT INTO Returns VALUES
(1,2,'Damaged','2025-01-10'),
(2,3,'Wrong Size','2025-01-11'),
(3,6,'Changed Mind','2025-01-12'),
(4,8,'Damaged','2025-01-15');
SELECT * FROM Orders;
SELECT * FROM Products;
SELECT * FROM Returns;
SELECT
o.order_id,
p.product_name,
r.return_reason
FROM Orders o
INNER JOIN Returns r
ON o.order_id = r.order_id
INNER JOIN Products p
ON o.product_id = p.product_id;

SELECT
return_reason,
COUNT(*) AS total_returns
FROM Returns
GROUP BY return_reason
ORDER BY total_returns DESC;

SELECT
p.category,
COUNT(r.return_id) AS returned_orders,
COUNT(o.order_id) AS total_orders,
ROUND(
COUNT(r.return_id)*100.0/
COUNT(o.order_id),2
) AS return_rate
FROM Orders o
LEFT JOIN Returns r
ON o.order_id=r.order_id
JOIN Products p
ON o.product_id=p.product_id
GROUP BY p.category;

SELECT
o.country,
COUNT(r.return_id) AS returns,
COUNT(o.order_id) AS orders_count,
ROUND(
COUNT(r.return_id)*100.0/
COUNT(o.order_id),2
) AS return_rate
FROM Orders o
LEFT JOIN Returns r
ON o.order_id=r.order_id
GROUP BY o.country
ORDER BY return_rate DESC;

SELECT
COUNT(r.return_id) AS total_returns,
COUNT(o.order_id) AS total_orders,
ROUND(
COUNT(r.return_id)*100.0/
COUNT(o.order_id),2
) AS overall_return_rate
FROM Orders o
LEFT JOIN Returns r
ON o.order_id=r.order_id;

SELECT
p.product_name,
COUNT(r.return_id) AS total_returns
FROM Orders o
JOIN Products p
ON o.product_id=p.product_id
JOIN Returns r
ON o.order_id=r.order_id
GROUP BY p.product_name
ORDER BY total_returns DESC;

SELECT
o.order_id,
o.country,
o.marketing_channel,
p.product_name,
p.category,
r.return_reason,
r.return_date
FROM Orders o
JOIN Products p
ON o.product_id=p.product_id
LEFT JOIN Returns r
ON o.order_id=r.order_id
ORDER BY o.order_id;

