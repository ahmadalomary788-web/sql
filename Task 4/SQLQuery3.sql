
CREATE DATABASE FoodDeliveryDB;
DROP DATABASE IF EXISTS FoodDeliveryDB;
USE FoodDeliveryDB;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(30),
    phone VARCHAR(15)
);

CREATE TABLE Restaurants (
    restaurant_id INT PRIMARY KEY,
    restaurant_name VARCHAR(30) NOT NULL,
    city VARCHAR(30)
);

CREATE TABLE MenuItems (
    item_id INT PRIMARY KEY,
    restaurant_id INT,
    item_name VARCHAR(30),
    price DECIMAL(10, 2),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    restaurant_id INT,
    order_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id) 
);

CREATE TABLE OrderDetails (
    order_id INT,
    item_id INT,
    quantity INT,
    unit_price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (item_id) REFERENCES MenuItems(item_id)
);

INSERT INTO Customers VALUES
(1, 'Ahmed',   '0791111111'),
(2, 'Hasan',    '0792222222'),
(3, 'Khaled',  '0793333333'),
(4, 'Ali',    '0794444444'),
(5, 'Omar',    '0795555555');

INSERT INTO Restaurants VALUES
(1, 'Burger King', 'Amman'),
(2, 'Pizza Hut',   'Amman'),
(3, 'KFC',         'Irbid'),
(4, 'Subway',      'Zarqa');

INSERT INTO MenuItems VALUES
(101, 1, 'Whopper',        7.50),
(102, 1, 'Cheeseburger',   5.00),
(103, 1, 'Fries',          2.50),
(104, 2, 'Margherita',    12.00),
(105, 2, 'Pepperoni',     14.00),
(106, 2, 'Garlic Bread',   3.00),
(107, 3, 'Zinger Burger',  6.50),
(108, 3, 'Bucket 6pcs',   15.00),
(109, 4, 'Tuna Sub',       8.00),
(110, 4, 'Veggie Delight', 7.00);


INSERT INTO Orders VALUES
(1, 1, 1, '2026-04-01', 'Delivered'), 
(2, 2, 2, '2026-04-01', 'Delivered'), 
(3, 3, 3, '2026-04-02', 'Pending'),   
(4, 1, 1, '2026-04-03', 'Preparing'), 
(5, 4, 2, '2026-04-03', 'Delivered'), 
(6, 5, 4, '2026-04-03', 'Pending');   

INSERT INTO OrderDetails VALUES
(1, 101, 2, 7.50),   
(1, 103, 1, 2.50),   
(2, 104, 1, 12.00),  
(2, 106, 2, 3.00),  
(3, 107, 3, 6.50),  
(4, 102, 2, 5.00),   
(4, 103, 2, 2.50),  
(5, 105, 1, 14.00),  
(5, 106, 1, 3.00),  
(6, 109, 2, 8.00),   
(6, 110, 1, 7.00);   

SELECT customer_id, customer_name, phone FROM Customers;
SELECT restaurant_name, city FROM Restaurants WHERE city = 'Amman';
SELECT item_name, price FROM MenuItems WHERE price BETWEEN 5.00 AND 8.00;
SELECT item_name, price FROM MenuItems ORDER BY price ASC;
SELECT order_id, customer_id, order_date, status FROM Orders WHERE order_date = '2026-04-03';
SELECT order_id, customer_id, order_date FROM Orders WHERE status = 'Delivered';
SELECT item_name, price FROM MenuItems WHERE restaurant_id = 2;
SELECT order_id, item_id, quantity, unit_price FROM OrderDetails WHERE quantity > 1;
SELECT DISTINCT city FROM Restaurants;
SELECT item_name, price FROM MenuItems ORDER BY price DESC;
SELECT customer_id, COUNT(order_id) AS num_orders FROM Orders GROUP BY customer_id;
SELECT SUM(quantity * unit_price) AS total_revenue FROM OrderDetails;
SELECT order_id, SUM(quantity * unit_price) AS total_price FROM OrderDetails GROUP BY order_id;
SELECT restaurant_id, AVG(price) AS avg_price FROM MenuItems GROUP BY restaurant_id;
SELECT restaurant_id, COUNT(item_id) AS num_items FROM MenuItems GROUP BY restaurant_id;


SELECT Customers.customer_name, Orders.order_id
FROM Customers
LEFT JOIN Orders 
ON Customers.customer_id = Orders.customer_id;

SELECT Customers.customer_name, Orders.order_id
FROM Customers
INNER JOIN Orders 
ON Customers.customer_id = Orders.customer_id;

SELECT MenuItems.item_name
FROM MenuItems
LEFT JOIN OrderDetails 
ON MenuItems.item_id = OrderDetails.item_id
WHERE OrderDetails.order_id IS NULL;

SELECT c.customer_name, o.order_id
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id;

SELECT 
    c.customer_name, 
    o.order_id, 
    m.item_name, 
    od.quantity, 
    (od.quantity * od.unit_price) AS total_price_per_item
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id
INNER JOIN OrderDetails od ON o.order_id = od.order_id
INNER JOIN MenuItems m ON od.item_id = m.item_id;

SELECT TOP 1 
    m.item_name, 
    SUM(od.quantity) AS total_ordered
FROM MenuItems m
INNER JOIN OrderDetails od ON m.item_id = od.item_id
GROUP BY m.item_id, m.item_name
ORDER BY total_ordered DESC;

SELECT 
    c.customer_name, 
    COUNT(DISTINCT o.restaurant_id) AS num_of_restaurants
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(DISTINCT o.restaurant_id) > 1;

