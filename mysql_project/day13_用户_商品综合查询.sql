-- ==================================================
-- 第 1 题
-- 按城市统计用户数量，显示 city, user_count。
-- ==================================================
SELECT city,
       COUNT(*) AS user_count
FROM users
GROUP BY city;

-- ==================================================
-- 第 2 题
-- 按会员等级统计用户数量，显示 member_level, user_count。
-- ==================================================
SELECT  member_level,
        COUNT(*) AS user_count
FROM users
GROUP BY member_level;

-- ==================================================
-- 第 3 题
-- 查询每个用户的订单数量，显示 user_id, user_name, order_count，要求保留没有下单的用户。
-- ==================================================

SELECT u.user_id,
       u.user_name,
       COUNT(o.order_id) AS  order_count
FROM users AS u
LEFT JOIN orders AS o
ON u.user_id = o.user_id
GROUP BY u.user_id,u.user_name;



SELECT u.user_id,
       u.user_name,
       COUNT(*) AS  order_count
FROM orders AS o
LEFT JOIN users AS u
ON u.user_id = o.user_id
GROUP BY u.user_id, u.user_name;

SELECT u.user_id,
       u.user_name,
       COUNT(*) AS  order_count
FROM orders AS o
LEFT JOIN users AS u
ON u.user_id = o.user_id
GROUP BY u.user_id, 


-- ==================================================
-- 第 4 题
-- 查询每个用户的实付总金额，显示 user_id, user_name, ，要求保留没有下单的用户。
-- ==================================================
SELECT u.user_id, 
       u.user_name, 
			 SUM(o.unit_price * o.quantity - o.discount_amount) AS total_actual_amount
FROM users AS u
LEFT JOIN orders AS o
ON u.user_id = o.user_id 
GROUP BY u.user_id,u.user_name;

SELECT u.user_id, 
       u.user_name, 
			 SUM(o.unit_price * o.quantity - o.discount_amount) AS total_actual_amount
FROM users AS u
LEFT JOIN orders AS o
ON u.user_id = o.user_id 
GROUP BY u.user_id;
-- ==================================================
-- 第 5 题
-- 按城市统计实付总金额，显示 city, total_actual_amount，只统计 Paid 订单。
-- ==================================================
SELECT u.city,
       ROUND(SUM(o.unit_price * o.quantity - o.discount_amount),2) AS total_actual_amount
FROM users AS u
INNER JOIN orders AS o
ON u.user_id = o.user_id
WHERE o.order_status = 'Paid'
GROUP BY  u.city;
-- ==================================================
-- 第 6 题
-- 查询没有下过订单的用户，显示 user_id, user_name, city。
-- ==================================================
SELECT u.user_id, 
       u.user_name, 
       u.city
FROM users AS u
LEFT JOIN orders AS o
ON u.user_id = o.user_id
WHERE o.user_id IS null;

-- ==================================================
-- 第 7 题
-- 按商品分类统计商品数量，显示 category, product_count。
-- ==================================================
SELECT category,
       COUNT(*) AS product_count
FROM products 
GROUP BY category;
-- ==================================================
-- 第 8 题
-- 按商品分类统计购买总件数，显示 category, total_quantity。
-- ==================================================
SELECT p.category,
       SUM(o.quantity) AS total_quantity
FROM products AS p
INNER JOIN orders as o
ON p.product_id = o.product_id
GROUP BY p.category;

-- ==================================================
-- 第 9 题
-- 查询每个商品的实付总金额，显示 product_id, product_name, total_actual_amount。
-- ==================================================
SELECT  p.product_id, 
        p.product_name,
				ROUND(SUM(o.unit_price * o.quantity - o.discount_amount),2) AS total_actual_amount
FROM products AS p
INNER JOIN orders AS o
ON p.product_id = o.product_id
GROUP BY  p.product_id, p.product_name;

-- ==================================================
-- 第 10 题
-- 查询没有被购买过的商品，显示 product_id, product_name, category。
-- ==================================================
SELECT p.product_id, 
       p.product_name, 
       p.category
FROM products AS p
LEFT JOIN orders AS o
ON p.product_id = o.product_id
WHERE o.product_id IS NULL;
-- ==================================================
-- 第 11 题
-- 按商品分类统计 Paid 订单实付总金额，显示 category, paid_actual_amount。
-- ==================================================
SELECT p.category,
       ROUND(SUM(o.unit_price * o.quantity - o.discount_amount),2) AS paid_actual_amount
FROM products AS p
INNER JOIN orders AS o
ON p.product_id = o.product_id 
WHERE o.order_status = 'Paid'
GROUP BY p.category;

-- ==================================================
-- 第 12 题
-- 查询每个城市、每个商品分类的实付总金额，显示 city, category, total_actual_amount。
-- ==================================================
SELECT u.city,
       p.category,
			  ROUND(SUM(o.unit_price * o.quantity - o.discount_amount),2) AS total_actual_amount
FROM orders AS o
LEFT JOIN users AS u
ON u.user_id = o.user_id
LEFT JOIN products AS p 
ON o.product_id = p.product_id
GROUP BY u.city,p.category;

      
