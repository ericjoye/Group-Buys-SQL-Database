-- Sample data for Group Buys Database

-- Insert sample users
INSERT INTO users (user_id, username, email, join_date) VALUES
(1, 'john_doe', 'john@example.com', '2024-01-15'),
(2, 'jane_smith', 'jane@example.com', '2024-01-20'),
(3, 'bob_wilson', 'bob@example.com', '2024-02-01'),
(4, 'alice_brown', 'alice@example.com', '2024-02-10'),
(5, 'charlie_davis', 'charlie@example.com', '2024-02-15');

-- Insert sample products
INSERT INTO products (product_id, product_name, regular_price, category) VALUES
(1, 'Wireless Mouse', 29.99, 'Electronics'),
(2, 'USB Cable Pack', 15.99, 'Electronics'),
(3, 'Notebook Set', 12.99, 'Stationery'),
(4, 'Mechanical Keyboard', 89.99, 'Electronics'),
(5, 'Desk Organizer', 24.99, 'Office Supplies');

-- Insert sample group buys
INSERT INTO group_buys (group_buy_id, product_id, group_price, minimum_participants, start_date, end_date, status) VALUES
(1, 1, 19.99, 5, '2024-03-01', '2024-03-15', 'active'),
(2, 2, 9.99, 10, '2024-03-05', '2024-03-20', 'active'),
(3, 3, 8.99, 8, '2024-02-15', '2024-02-28', 'completed'),
(4, 4, 59.99, 15, '2024-03-10', '2024-03-25', 'active'),
(5, 5, 16.99, 6, '2024-02-20', '2024-03-05', 'completed');

-- Insert sample participants
INSERT INTO participants (participant_id, group_buy_id, user_id, joined_date) VALUES
(1, 1, 1, '2024-03-02'),
(2, 1, 2, '2024-03-03'),
(3, 1, 3, '2024-03-04'),
(4, 2, 1, '2024-03-06'),
(5, 2, 4, '2024-03-07'),
(6, 3, 3, '2024-02-16'),
(7, 3, 5, '2024-02-17'),
(8, 4, 2, '2024-03-11'),
(9, 4, 5, '2024-03-12'),
(10, 5, 1, '2024-02-21');
