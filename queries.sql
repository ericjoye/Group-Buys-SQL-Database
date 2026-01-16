-- Example Queries for Group Buys Database

-- ========================================
-- BASIC SELECT QUERIES
-- ========================================

-- Get all active group buys
SELECT * FROM group_buys
WHERE status = 'active';

-- List all products sorted by price
SELECT product_name, regular_price
FROM products
ORDER BY regular_price DESC;


-- ========================================
-- JOIN QUERIES
-- ========================================

-- Show group buys with product details
SELECT
    gb.group_buy_id,
    p.product_name,
    p.regular_price,
    gb.group_price,
    gb.status
FROM group_buys gb
JOIN products p ON gb.product_id = p.product_id;

-- List all participants with their usernames and group buy info
SELECT
    u.username,
    p.product_name,
    gb.group_price,
    pt.joined_date
FROM participants pt
JOIN users u ON pt.user_id = u.user_id
JOIN group_buys gb ON pt.group_buy_id = gb.group_buy_id
JOIN products p ON gb.product_id = p.product_id;


-- ========================================
-- AGGREGATE FUNCTIONS
-- ========================================

-- Count participants in each group buy
SELECT
    gb.group_buy_id,
    p.product_name,
    COUNT(pt.participant_id) as participant_count
FROM group_buys gb
JOIN products p ON gb.product_id = p.product_id
LEFT JOIN participants pt ON gb.group_buy_id = pt.group_buy_id
GROUP BY gb.group_buy_id, p.product_name;

-- Calculate total savings per group buy
SELECT
    p.product_name,
    (p.regular_price - gb.group_price) as savings_per_person,
    COUNT(pt.participant_id) as participants,
    (p.regular_price - gb.group_price) * COUNT(pt.participant_id) as total_savings
FROM group_buys gb
JOIN products p ON gb.product_id = p.product_id
LEFT JOIN participants pt ON gb.group_buy_id = pt.group_buy_id
GROUP BY gb.group_buy_id, p.product_name, p.regular_price, gb.group_price;


-- ========================================
-- WHERE CLAUSE EXAMPLES
-- ========================================

-- Find group buys that met minimum participation
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

-- Get electronics category group buys
SELECT
    gb.group_buy_id,
    p.product_name,
    p.category,
    gb.group_price
FROM group_buys gb
JOIN products p ON gb.product_id = p.product_id
WHERE p.category = 'Electronics'
AND gb.status = 'active';
