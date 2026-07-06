-- ==================================================
-- 第 1 题
-- 查询所有用户及其订单编号，显示 user_id, user_name, order_id
-- ==================================================
SELECT u.user_id,
			u.user_name, 
			o.order_id
FROM users AS u
LEFT JOIN orders AS o
ON u.user_id = o.user_id;

-- ==================================================
-- 第 2 题
-- 查询所有用户及其订单状态，显示 user_name, order_status
-- ==================================================
SELECT u.user_name,
       o.order_status
FROM users as u
LEFT JOIN orders AS o
ON u.user_id = o.user_id;

-- ==================================================
-- 第 3 题
-- 查询所有用户的订单数量，显示 user_name, order_count
-- ==================================================
SELECT u.user_name,
			COUNT(o.order_id) AS order_count
FROM  users AS u
LEFT JOIN orders AS o
ON u.user_id = o.user_id
GROUP BY u.user_name;

-- ==================================================
-- 第 4 题
-- 查询没有下过订单的用户，显示 user_id, user_name
-- ==================================================
SELECT u.user_id,
       u.user_name
FROM users	AS u
LEFT JOIN orders AS o
ON u.user_id = o.user_id	 
WHERE o.order_id is NULL;
 

-- =========as=========================================
-- 第 5 题
-- 查询所有商品及其订单编号，显示 product_id, product_name, order_id
-- ==================================================
SELECT  p.product_id,
        p.product_name,
				o.order_id
FROM products AS p
LEFT JOIN orders AS o
ON p.product_id = o.product_id;

-- ==================================================
-- 第 6 题
-- 查询所有商品的订单数量，显示 product_name, order_count
-- ==================================================
SELECT  p.product_name,
      COUNT(o.order_id) AS order_count
FROM products AS p
LEFT JOIN orders AS o
ON p.product_id = o.product_id
GROUP BY p.product_name;
			

-- ==================================================
-- 第 7 题
-- 查询没有被购买过的商品，显示 product_id, product_name
-- ==================================================
SELECT p.product_id,
       p.product_name
FROM products AS p
LEFT JOIN orders AS o
ON p.product_id = o.product_id
WHERE o.order_id IS NULL;

-- ==================================================
-- 第 8 题
-- 用 RIGHT JOIN 查询所有用户及其订单编号，然后改写成 LEFT JOIN
-- ==================================================
SELECT u.user_id,
       u.user_name,
			 o.order_id
FROM orders AS o
RIGHT JOIN users AS u
on o.user_id = u.user_id;


SELECT u.user_id,
       u.user_name,
			 o.order_id
FROM users AS u
LEFT JOIN orders AS o
ON  u.user_id = o.user_id;
-- ==================================================
-- 第 9 题
-- 查询所有用户的实付总金额，显示 user_name, total_actual_amount，没有订单的用户金额可以为空
-- ==================================================
 SELECT  u.user_name,
         SUM(o.quantity * o.unit_price - o.discount_amount) AS total_actual_amount
 FROM users AS u
 LEFT JOIN orders AS o
 on u.user_id = o.user_id
 GROUP BY  u.user_name;

-- ==================================================
-- 第 10 题
-- 查询所有商品分类的购买总件数，显示 category, total_quantity，注意保留没有订单的商品
-- ================================================== 
SELECT p.category,
			 SUM(o.quantity) AS total_quantity
FROM products AS p
LEFT JOIN orders AS o
ON p.product_id = o.product_id
GROUP BY p.category;


SELECT u.user_name,
       o.order_id
FROM users AS u
LEFT JOIN orders AS o
ON u.user_id = o.user_id;



SELECT u.user_id,
       u.user_name,
       o.order_id
FROM users AS u
LEFT JOIN orders AS o
ON u.user_id = o.user_id
WHERE o.order_id IS NULL;






SELECT COUNT(*) AS no_order_user_count
FROM users AS u
LEFT JOIN orders AS o
ON u.user_id = o.user_id
WHERE o.order_id IS NULL;