-- ==================================================
-- 第 1 题
-- 查询用户数量大于 2 的城市，显示 city, user_count
-- ==================================================
SELECT city,
COUNT(*) AS user_count
FROM users 
GROUP BY city
HAVING COUNT(*) > 2;

-- ==================================================
-- 第 2 题
-- 查询用户数量大于 2 的会员等级，显示 member_level, user_count
-- ==================================================
SELECT member_level,
COUNT(*) AS user_count
FROM users 
GROUP BY member_level
HAVING COUNT(*)>2;

-- ==================================================
-- 第 3 题
-- 查询商品数量大于 2 的商品分类，显示 category, product_count
-- ==================================================
SELECT category,
COUNT(*) AS product_count
FROM products 
GROUP BY category
HAVING COUNT(*) > 2;

-- ==================================================
-- 第 4 题
-- 查询平均价格大于 100 的商品分类，显示 category, avg_price
-- ==================================================
SELECT category,
AVG(price) AS avg_price
FROM products 
GROUP BY category
HAVING AVG(price) > 100;
-- ==================================================
-- 第 5 题
-- 查询最高价格大于 300 的商品分类，显示 category, max_price
-- ==================================================
SELECT category,
max(price) AS  max_price
FROM products 
GROUP BY category
HAVING max(price) > 300;

-- ==================================================
-- 第 6 题
-- 查询最低价格小于 50 的商品分类，显示 category, min_price
-- ==================================================
SELECT category,
min(price) AS  min_price
FROM products 
GROUP BY category
HAVING min(price) < 50;

-- ==================================================
-- 第 7 题
-- 查询订单数量大于 2 的订单状态，显示 order_status, order_count
-- ==================================================
SELECT order_status,
COUNT(*) AS order_count
FROM orders
GROUP BY order_status
HAVING COUNT(*) > 2;

-- ==================================================
-- 第 8 题
-- 查询订单数量大于 2 的支付方式，显示 payment_method, order_count
-- ==================================================
SELECT payment_method,
COUNT(*) AS order_count
FROM orders 
GROUP BY payment_method
HAVING COUNT(*) > 2;

-- ==================================================
-- 第 9 题
-- 查询购买总件数大于 5 的支付方式，显示 payment_method, total_quantity
-- ==================================================
SELECT payment_method,
SUM(quantity) AS total_quantity
FROM orders 
GROUP BY payment_method
HAVING SUM(quantity) >5; 
  
-- ==================================================
-- 第 10 题
-- 查询总优惠金额大于 50 的支付方式，显示 payment_method, total_discount
-- ==================================================
SELECT payment_method,
SUM(discount_amount) AS total_discount
FROM orders 
GROUP BY payment_method
HAVING SUM(discount_amount) >50; 

-- ==================================================
-- 第 11 题
-- 查询实付总金额大于 500 的订单状态，显示 order_status, total_actual_amount
-- ==================================================
-- ==================================================
SELECT order_status,
SUM(unit_price*quantity-discount_amount) AS total_actual_amount
FROM orders 
GROUP BY order_status
HAVING SUM(unit_price*quantity-discount_amount) >500; 

-- ==================================================
-- 第 12 题
-- 查询平均实付金额大于 100 的支付方式，显示 payment_method, avg_actual_amount
-- ==================================================
SELECT payment_method,
AVG(unit_price*quantity-discount_amount) AS avg_actual_amount
FROM  orders 
GROUP BY payment_method
HAVING AVG(unit_price*quantity-discount_amount) >100;
-- ==================================================
-- 第 13 题
-- 查询 Paid 订单中，订单数量大于 2 的支付方式，显示 payment_method, paid_order_count
-- ==================================================
SELECT payment_method,
COUNT(*) AS paid_order_count
FROM orders
WHERE order_status = 'Paid'
GROUP BY payment_method
HAVING COUNT(*) > 2;

-- =========== =======================================
-- 第 14 题
-- 查询价格大于 100 的商品中，商品数量大于 1 的分类，显示 category, expensive_product_count
-- ==================================================
SELECT category,
COUNT(*) AS expensive_product_count
FROM products
WHERE price > 100
GROUP BY category
HAVING COUNT(*)  > 1;

-- ==================================================
-- 第 15 题
-- 查询年龄大于 25 岁的用户中，用户数量大于 1 的城市，显示 city, user_count
-- ==================================================
SELECT  city,
COUNT(*) AS user_count
FROM users
WHERE age > 25 
GROUP BY city
HAVING COUNT(*) >1 ;

