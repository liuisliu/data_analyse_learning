-- ==================================================
-- 第 1 题
-- 查询所有订单的订单编号、订单日期、订单状态、购买数量、实付金额，显示 order_id, order_date, order_status, quantity, actual_amount。
-- ==================================================
SELECT order_id, 
       order_date,
       order_status, 
       quantity, 
			 unit_price * quantity -discount_amount AS actual_amount
FROM orders;

-- ==================================================
-- 第 2 题
-- 统计所有订单数量、购买总件数、实付总金额，显示 order_count, total_quantity, total_actual_amount。
-- ==================================================
SELECT 
COUNT(*) AS  order_count,
SUM(quantity) AS total_quantity,
SUM(unit_price * quantity - discount_amount) AS total_actual_amount
FROM orders;
-- ==================================================
-- 第 3 题
-- 统计 Paid 订单数量和 Paid 订单实付总金额，显示 paid_order_count, paid_actual_amount。
-- ==================================================
SELECT 
COUNT(*) AS paid_order_count,
SUM(unit_price * quantity - discount_amount) AS total_actual_amount
FROM orders
WHERE order_status = 'Paid';
-- ==================================================
-- 第 4 题
-- 按订单状态统计订单数量和实付总金额，显示 order_status, order_count, total_actual_amount。
-- ==================================================
SELECT order_status,
       COUNT(*) AS  order_count,
			 SUM(unit_price * quantity - discount_amount) AS total_actual_amount
FROM orders
GROUP BY order_status;
-- ==================================================
-- 第 5 题
-- 按支付方式统计订单数量、平均实付金额，平均实付金额保留 2 位小数，显示 payment_method, order_count, avg_actual_amount。
-- ==================================================
SELECT payment_method,
       COUNT(*) AS order_count,
			 ROUND(AVG(unit_price * quantity - discount_amount),2) AS avg_actual_amount
FROM orders
GROUP BY payment_method;

-- ==================================================
-- 第 6 题
-- 按订单月份统计订单数量和实付总金额，显示 order_month, order_count, total_actual_amount。
-- ==================================================
SELECT DATE_FORMAT(order_date,'%Y-%m') AS order_month,
			 COUNT(*) AS order_count,
			 SUM(unit_price * quantity - discount_amount) AS total_actual_amount
FROM orders 
GROUP BY DATE_FORMAT(order_date,'%Y-%m');
-- ==================================================
-- 第 7 题
-- 查询实付金额大于 200 的订单，显示 order_id, user_id, order_date, actual_amount。
-- ==================================================
SELECT order_id, 
       user_id, 
       order_date,
			 unit_price * quantity - discount_amount AS actual_amount
FROM orders 
WHERE unit_price * quantity - discount_amount > 200;
-- ==================================================
-- 第 8 题
-- 按城市统计 Paid 订单数量和 Paid 订单实付总金额，显示 city, paid_order_count, paid_actual_amount。
-- ==================================================
SELECT u.city, 
       COUNT(*) AS paid_order_count,
			 SUM(o.unit_price * o.quantity - o.discount_amount) AS paid_actual_amount
FROM users AS u
INNER JOIN orders AS o
ON u.user_id = o.user_id
WHERE o.order_status = 'Paid'
GROUP BY u.city;



-- ==================================================
-- 第 9 题
-- 按商品分类统计购买总件数和实付总金额，显示 category, total_quantity, total_actual_amount。
-- ==================================================
SELECT p.category,
       SUM(o.quantity) AS total_quantity,
			 SUM(o.unit_price * o.quantity - o.discount_amount) AS total_actual_amount
FROM products AS p
INNER JOIN orders AS o
ON p.product_id = o.product_id
GROUP BY p.category;
-- ==================================================
-- 第 10 题
-- 查询每个用户的订单数量和实付总金额，显示 user_name, order_count, total_actual_amount。
-- ==================================================
SELECT u.user_name,
       COUNT(*) AS order_count,
			 SUM(o.unit_price * o.quantity - o.discount_amount) AS total_actual_amount
FROM users AS u
INNER JOIN orders AS o
ON u.user_id = o.user_id
GROUP BY  u.user_name;
-- ==================================================
-- 第 11 题
-- 按会员等级统计订单数量和平均实付金额，显示 member_level, order_count, avg_actual_amount。
-- ==================================================
SELECT u.member_level,
       COUNT(*) AS order_count,
			 AVG(o.unit_price * o.quantity - o.discount_amount) AS avg_actual_amount
FROM users AS u
INNER JOIN orders AS o
ON u.user_id = o.user_id
GROUP BY u.member_level;
-- ==================================================
-- 第 12 题
-- 按订单月份和订单状态统计订单数量，显示 order_month, order_status, order_count。
-- ==================================================
SELECT 
      DATE_FORMAT(order_date,'%Y-%m') AS order_mont,
			order_status,
			COUNT(*) AS  order_count
FROM orders
GROUP BY DATE_FORMAT(order_date,'%Y-%m'),order_status;



