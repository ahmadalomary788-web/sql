CREATE DATABASE Gallery;
USE Gallery;

CREATE TABLE brands (
    brand_id INT PRIMARY KEY,
    brand_name VARCHAR(50)
);

CREATE TABLE cars (
    car_id INT PRIMARY KEY,
    brand_id INT,
    model_name VARCHAR(50),
    car_year INT,
    price DECIMAL(10,2),
    color VARCHAR(20),
    stock_quantity INT,
    FOREIGN KEY (brand_id) REFERENCES brands(brand_id)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    car_id INT,
    customer_id INT,
    sale_date DATE,
    quantity INT,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (car_id) REFERENCES cars(car_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO brands VALUES
(1, 'BMW'),
(2, 'Porsche'),
(3, 'Ford');

INSERT INTO cars VALUES
(1, 1, 'M4 GTS', 2016, 80000, 'Gray', 5),
(2, 1, 'M5',   2023, 30000, 'Black', 3),
(3, 1, 'X5',      2024, 60000, 'Gray',  2),
(4, 2, '911 GT3 RS',2023, 45000, 'White', 4),
(5, 3, 'Raptor', 2022, 22000, 'Blue',  6),
(6, 2, 'Panemrra',  2024, 35000, 'Black', 2);

INSERT INTO customers VALUES
(1, 'Ahmad', 'Amman'),
(2, 'Mohammad',  'Zarqa'),
(3, 'Omar',  'Irbid'),
(4, 'Ali',  'Amman');

INSERT INTO sales VALUES
(1, 1, 1, '2026-01-10', 1, 20000),
(2, 2, 2, '2026-01-15', 1, 30000),
(3, 3, 3, '2026-02-01', 1, 60000),
(4, 1, 4, '2026-02-10', 2, 40000),
(5, 5, 1, '2026-03-05', 1, 22000),
(6, 6, 2, '2026-03-20', 1, 35000),
(7, 4, 3, '2026-03-25', 1, 45000);


SELECT b.brand_name, COUNT(c.car_id) AS black_cars_count
FROM brands b
JOIN cars c ON b.brand_id = c.brand_id
WHERE c.color = 'Gray'
GROUP BY b.brand_name;

SELECT b.brand_name, AVG(c.price) AS avg_price
FROM brands b
JOIN cars c ON b.brand_id = c.brand_id
WHERE c.car_year >= 2023
GROUP BY b.brand_name;

SELECT b.brand_name, COUNT(c.car_id) AS number_of_cars
FROM brands b
JOIN cars c ON b.brand_id = c.brand_id
GROUP BY b.brand_name
HAVING COUNT(c.car_id) > 2;

SELECT b.brand_name, AVG(c.price) AS avg_price
FROM brands b
JOIN cars c ON b.brand_id = c.brand_id
GROUP BY b.brand_name
HAVING AVG(c.price) > 25000;



