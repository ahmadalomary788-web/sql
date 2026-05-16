CREATE DATABASE Dabirha;
USE Dabirha;
 

CREATE TABLE Admin (
    admin_id INT PRIMARY KEY IDENTITY(1,1),
    full_name NVARCHAR(50) NOT NULL,
    email NVARCHAR(50) UNIQUE NOT NULL,
    password NVARCHAR(100) NOT NULL
    );

CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL UNIQUE,
    email NVARCHAR(50) UNIQUE NOT NULL,
    phone NVARCHAR (15) NOT NULL UNIQUE,
    password NVARCHAR(100) NOT NULL,
    wallet_number NVARCHAR(50) NULL UNIQUE,
    is_verified BIT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE Category (
    category_id INT PRIMARY KEY IDENTITY(1,1),
    category_name NVARCHAR(30) NOT NULL

);

CREATE TABLE handtools (
    tool_id INT PRIMARY KEY IDENTITY(1,1),
    tool_name NVARCHAR(50) NOT NULL,
    description NVARCHAR(200) NULL,
    price_per_day DECIMAL(8,2) NOT NULL,
    city NVARCHAR(30) NOT NULL,
    sub_category NVARCHAR(30) NULL, 
    image_url NVARCHAR(200) NULL,
    owner_id INT NOT NULL, 
    status NVARCHAR(20) DEFAULT 'متاح',
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (owner_id) REFERENCES Users(user_id)
);


CREATE TABLE heavy_vehicles (
    vehicle_id INT PRIMARY KEY IDENTITY(1,1),
    vehicle_name NVARCHAR(50) NOT NULL,
    description NVARCHAR(200) NULL,
    price_per_day DECIMAL(8,2) NOT NULL,
    city NVARCHAR(30) NOT NULL,
    sub_category NVARCHAR(30) NULL,  
    image_url NVARCHAR(200) NULL,
    owner_id INT NOT NULL,
    status NVARCHAR(20) DEFAULT 'متاح',
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (owner_id) REFERENCES Users(user_id)
);


CREATE TABLE listing (
    listing_id INT PRIMARY KEY IDENTITY(1,1),
    type NVARCHAR(20) NOT NULL,  
    item_id INT NOT NULL,        
    user_id INT NOT NULL,        
    is_featured BIT DEFAULT 0,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    views_count INT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
