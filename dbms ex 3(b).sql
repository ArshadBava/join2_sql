create database marketdb;
use marketdb;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(20) NOT NULL,
    contact_info VARCHAR(20) NOT NULL
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Orders(
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price_per_unit DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

SELECT c.customer_name, p.product_name FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id;

SELECT c.customer_name, o.order_id, o.order_date FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id;

SELECT p.product_name, c.customer_name FROM Products p
LEFT JOIN OrderDetails od ON p.product_id = od.product_id
LEFT JOIN Orders o ON od.order_id = o.order_id
LEFT JOIN Customers c ON o.customer_id = c.customer_id;

SELECT c.customer_name, p.product_name, od.quantity, od.price_per_unit FROM Customers c
CROSS JOIN Products p
LEFT JOIN Orders o ON c.customer_id = o.customer_id
LEFT JOIN OrderDetails od ON o.order_id = od.order_id AND p.product_id = od.product_id;

SELECT c.customer_name FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderDetails od ON o.order_id = od.order_id
GROUP BY c.customer_name HAVING SUM(od.quantity) > 10;

INSERT INTO Customers (customer_id, customer_name, contact_info) VALUES
(1, 'Arshad', '9466582620'),
(2, 'Rizwan', '7356393956'),
(3, 'mohit', '9595686462'),
(4, 'Thaju', '7355845122');

INSERT INTO Products (product_id, product_name, price) VALUES
(101, 'Mobile', 10000.00),
(102, 'Headset', 2000.00),
(103, 'Laptop', 300000.00),
(104, 'Laptop', 450000.00);

INSERT INTO Orders (order_id, customer_id, order_date) VALUES
(201, 1, '2024-09-01'),
(202, 2, '2024-09-02'),
(203, 3, '2024-09-03'),
(204, 4, '2024-09-03');

INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity, price_per_unit) VALUES
(301, 201, 101, 2, 10000.00),
(302, 203, 102, 10, 2000.00),
(303, 202, 103, 5, 300000.00),
(304, 203, 101, 3, 10000.00),
(305, 204, 104, 1, 450000.00);






