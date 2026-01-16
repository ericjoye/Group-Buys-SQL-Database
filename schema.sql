-- Group Buys Database Schema
-- Creates tables for managing group buying campaigns

-- Users table
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50),
    email VARCHAR(100),
    join_date DATE
);

-- Products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    regular_price DECIMAL(10,2),
    category VARCHAR(50)
);

-- Group Buys table
CREATE TABLE group_buys (
    group_buy_id INT PRIMARY KEY,
    product_id INT,
    group_price DECIMAL(10,2),
    minimum_participants INT,
    start_date DATE,
    end_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Participants table
CREATE TABLE participants (
    participant_id INT PRIMARY KEY,
    group_buy_id INT,
    user_id INT,
    joined_date DATE,
    FOREIGN KEY (group_buy_id) REFERENCES group_buys(group_buy_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
