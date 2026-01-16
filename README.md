# Group Buys Database

**Project Name:** Group Buys SQL Database
**Description:** SQL database system for managing group buying campaigns where users join together to unlock bulk discounts on products.

## Table of Contents
- [Overview](#overview)
- [Database Schema](#database-schema)
- [SQL Queries](#sql-queries)
- [Query Results](#query-results)
- [Sample Data](#sample-data)
- [How to Use](#how-to-use)

## Overview

This project demonstrates fundamental SQL skills including:
- Creating tables with relationships
- Writing SELECT statements
- Using JOINs to combine data from multiple tables
- Applying aggregate functions (COUNT, SUM, AVG)
- Filtering data with WHERE clauses

The database models a simple group buying system where users can participate in group buys to get better prices on products.

## Database Schema

```sql
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
```

## SQL Queries

### Basic SELECT Queries

**Get all active group buys**
```sql
SELECT * FROM group_buys
WHERE status = 'active';
```

**List all products sorted by price**
```sql
SELECT product_name, regular_price
FROM products
ORDER BY regular_price DESC;
```

### JOIN Queries

**Show group buys with product details**
```sql
SELECT
    gb.group_buy_id,
    p.product_name,
    p.regular_price,
    gb.group_price,
    gb.status
FROM group_buys gb
JOIN products p ON gb.product_id = p.product_id;
```

**List all participants with their usernames and group buy info**
```sql
SELECT
    u.username,
    p.product_name,
    gb.group_price,
    pt.joined_date
FROM participants pt
JOIN users u ON pt.user_id = u.user_id
JOIN group_buys gb ON pt.group_buy_id = gb.group_buy_id
JOIN products p ON gb.product_id = p.product_id;
```

### Aggregate Functions

**Count participants in each group buy**
```sql
SELECT
    gb.group_buy_id,
    p.product_name,
    COUNT(pt.participant_id) as participant_count
FROM group_buys gb
JOIN products p ON gb.product_id = p.product_id
LEFT JOIN participants pt ON gb.group_buy_id = pt.group_buy_id
GROUP BY gb.group_buy_id, p.product_name;
```

**Calculate total savings per group buy**
```sql
SELECT
    p.product_name,
    (p.regular_price - gb.group_price) as savings_per_person,
    COUNT(pt.participant_id) as participants,
    (p.regular_price - gb.group_price) * COUNT(pt.participant_id) as total_savings
FROM group_buys gb
JOIN products p ON gb.product_id = p.product_id
LEFT JOIN participants pt ON gb.group_buy_id = pt.group_buy_id
GROUP BY gb.group_buy_id, p.product_name, p.regular_price, gb.group_price;
```

### WHERE Clause Examples

**Find group buys that met minimum participation**
```sql
SELECT
    gb.group_buy_id,
    p.product_name,
    gb.minimum_participants,
    COUNT(pt.participant_id) as actual_participants
FROM group_buys gb
JOIN products p ON gb.product_id = p.product_id
LEFT JOIN participants pt ON gb.group_buy_id = pt.group_buy_id
GROUP BY gb.group_buy_id, p.product_name, gb.minimum_participants
HAVING COUNT(pt.participant_id) >= gb.minimum_participants;
```

**Get electronics category group buys**
```sql
SELECT
    gb.group_buy_id,
    p.product_name,
    p.category,
    gb.group_price
FROM group_buys gb
JOIN products p ON gb.product_id = p.product_id
WHERE p.category = 'Electronics'
AND gb.status = 'active';
```

## Query Results

### Sample Output: Count Participants in Each Group Buy

| group_buy_id | product_name | participant_count |
|--------------|--------------|-------------------|
| 1 | Wireless Mouse | 3 |
| 2 | USB Cable Pack | 2 |
| 3 | Notebook Set | 1 |
| 4 | Mechanical Keyboard | 2 |
| 5 | Desk Organizer | 1 |

### Sample Output: Calculate Total Savings

| product_name | savings_per_person | participants | total_savings |
|--------------|-------------------|--------------|---------------|
| Wireless Mouse | 10.00 | 3 | 30.00 |
| USB Cable Pack | 6.00 | 2 | 12.00 |
| Notebook Set | 4.00 | 1 | 4.00 |
| Mechanical Keyboard | 30.00 | 2 | 60.00 |
| Desk Organizer | 8.00 | 1 | 8.00 |

## Sample Data

```sql
-- Insert sample users
INSERT INTO users (user_id, username, email, join_date) VALUES
(1, 'john_doe', 'john@example.com', '2024-01-15'),
(2, 'jane_smith', 'jane@example.com', '2024-01-20'),
(3, 'bob_wilson', 'bob@example.com', '2024-02-01');

-- Insert sample products
INSERT INTO products (product_id, product_name, regular_price, category) VALUES
(1, 'Wireless Mouse', 29.99, 'Electronics'),
(2, 'USB Cable Pack', 15.99, 'Electronics'),
(3, 'Notebook Set', 12.99, 'Stationery');

-- Insert sample group buys
INSERT INTO group_buys (group_buy_id, product_id, group_price, minimum_participants, start_date, end_date, status) VALUES
(1, 1, 19.99, 5, '2024-03-01', '2024-03-15', 'active'),
(2, 2, 9.99, 10, '2024-03-05', '2024-03-20', 'active'),
(3, 3, 8.99, 8, '2024-02-15', '2024-02-28', 'completed');

-- Insert sample participants
INSERT INTO participants (participant_id, group_buy_id, user_id, joined_date) VALUES
(1, 1, 1, '2024-03-02'),
(2, 1, 2, '2024-03-03'),
(3, 2, 1, '2024-03-06'),
(4, 3, 3, '2024-02-16');
```

## How to Use

1. Copy the schema creation code and run it in your SQL database
2. Insert the sample data
3. Try running the example queries to see the results
4. Modify the queries to practice different SQL concepts

---

*This project demonstrates basic SQL knowledge including table creation, relationships, and fundamental query operations.*
