-- ==================================================
-- 第 1 题
-- 查询所有订单的订单编号、订单日期、订单年份、订单月份，显示 order_id, order_date, order_year, order_month。
-- ==================================================
SELECT order_id,
       order_date,
			 YEAR(order_date) AS order_year, 
			MONTH(order_date) AS order_month
FROM orders;


-- ==================================================
-- 第 2 题
-- 按订单月份统计订单数量，显示 order_month, order_count。
-- ==================================================
SELECT  MONTH(order_date) AS order_month,
				COUNT(*) AS order_count
FROM orders
GROUP BY MONTH(order_date);

SELECT DATE_FORMAT(order_date, '%Y-%m') AS order_month,
       COUNT(*) AS order_count
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m');

-- ==================================================
-- 第 3 题
-- 查询订单编号、用户姓名、注册日期、订单日期、注册到下单相差天数，显示 order_id, user_name, signup_date, order_date, days_from_signup_to_order。
-- ==================================================
SELECT o.order_id,
       u.user_name, 
       u.signup_date, 
			 o.order_date, 
 DATEDIFF( o.order_date,u.signup_date) AS days_from_signup_to_order
 FROM orders AS o
 INNER JOIN users AS u
 ON o.user_id = u.user_id;
        

-- ==================================================
-- 第 4 题
-- 查询用户编号、用户姓名、城市，并把用户名和城市拼接成 user_city，显示 user_id, user_name, city, user_city。
-- ==================================================
SELECT user_id, 
       user_name, 
			 city,
       CONCAT(user_name,'-',city) AS user_city
FROM users;

-- ==================================================
-- 第 5 题
-- 查询商品编号、商品名称、商品名称长度，显示 product_id, product_name, product_name_length。
-- ==================================================
SELECT  product_id,
        product_name, 
				LENGTH(product_name) AS product_name_length
FROM products;

-- ==================================================
-- 第 6 题
-- 查询商品编号、商品名称、供应商，并去掉供应商字段前后空格，显示 product_id, product_name, clean_supplier。
-- ================product_id, product_name, 
SELECT product_id, 
       product_name, 
			 TRIM(supplier) AS clean_supplier
FROM products;
-- ==================================================
-- 第 7 题
-- 查询订单编号和实付金额，实付金额保留 2 位小数，显示 order_id, actual_amount。
-- ==================================================
SELECT  order_id,
        ROUND(unit_price * quantity - discount_amount , 2)  AS actual_amount
FROM  orders;

-- ==================================================
-- 第 8 题
-- 按支付方式统计平均实付金额，结果保留 2 位小数，显示 payment_method, avg_actual_amount。
-- ==================================================
SELECT payment_method,
       ROUND(AVG(unit_price * quantity - discount_amount),2) AS avg_actual_amount
FROM orders 
GROUP BY payment_method;

-- ==================================================
-- 第 9 题
-- 查询商品编号、商品名称、原价格、向上取整价格、向下取整价格，显示 product_id, product_name, price, ceil_price, floor_price。
-- ==================================================
 SELECT product_id, 
        product_name, 
        price,
				CEIL(price) AS  ceil_price,
				FLOOR(price) AS  floor_price
FROM products;
 
-- ==================================================
-- 第 10 题
-- 按订单月份统计实付总金额，金额保留 2 位小数，显示 order_month, total_actual_amount。
-- ==================================================

SELECT 
  DATE_FORMAT(order_date,'%Y-%m') AS order_month,
  ROUND(SUM(unit_price * quantity - discount_amount),2) AS total_actual_amount
FROM orders
GROUP BY   DATE_FORMAT(order_date,'%Y-%m');
 
-- ==================================================
-- 第 11 题
-- 按城市和注册年份统计用户数量，显示 city, signup_year, user_count。
-- ==================================================
SELECT city,
       YEAR(signup_date) AS signup_year,
			 COUNT(*) AS user_count 
FROM users 
GROUP BY city,YEAR(signup_date);
			 

-- ==================================================
-- 第 12 题
-- 按商品分类统计平均价格，平均价格保留 2 位小数，显示 category, avg_price。
-- ==================================================
SELECT category,
			ROUND(AVG(price),2) AS avg_price
FROM products
GROUP BY category;