-- 第1题
-- 创建或替换视图 v_user_order_counts，保存每个用户的订单数量。
-- 显示字段：user_id, order_count
-- ==================================================
CREATE  or REPLACE  VIEW v_user_order_counts AS
SELECT 
      user_id,
			count(*) AS  order_count 
FROM orders
GROUP BY user_id;

-- ==================================================
-- 第2题
-- 查询视图 v_user_order_counts，筛选订单数量不少于 2 的用户。
-- 显示字段：user_id, order_count
-- ==================================================
SELECT 
      user_id,
			order_count
FROM v_user_order_counts
WHERE order_count >= 2
ORDER BY order_count DESC;

-- ==================================================
-- 第3题
-- 创建或替换视图 v_user_totals，保存每个用户的总实付金额。
-- 显示字段：user_id, total_amount
-- ==================================================
CREATE OR REPLACE VIEW v_user_totals AS
SELECT
      user_id,
			sum(quantity * unit_price - discount_amount) AS total_amount
FROM  orders
GROUP BY user_id;

-- ==================================================
-- 第4题
-- 查询视图 v_user_totals，按总实付金额从高到低显示前 3 名用户。
-- 显示字段：user_id, total_amount
-- ==================================================
SELECT
      user_id, 
			total_amount
FROM v_user_totals
ORDER BY total_amount DESC
LIMIT 3;

-- ==================================================
-- 第5题
-- 使用视图 v_user_totals 关联 users 表，查询用户编号、姓名、城市和总实付金额。
-- 只显示有订单的用户，并按总实付金额从高到低排序。
-- 显示字段：user_id, user_name, city, total_amount
-- ==================================================
SELECT
      vut.user_id,
			u.user_name,
			u.city,
			vut.total_amount
FROM v_user_totals AS vut
INNER JOIN users AS u
ON vut.user_id = u.user_id
ORDER BY  vut.total_amount DESC;
-- ==================================================
-- 第6题
-- 创建或替换视图 v_daily_sales，保存每个订单日期的订单数量和总实付金额。
-- 显示字段：order_date, order_count, daily_amount
-- ==================================================
CREATE OR REPLACE VIEW v_daily_sales AS
SELECT 
      order_date,
      count(*) AS order_count,
			sum(quantity * unit_price - discount_amount) AS daily_amount
FROM orders
GROUP BY order_date;

-- ==================================================
-- 第7题
-- 查询视图 v_daily_sales，筛选订单数量大于等于 2 的日期。
-- 显示字段：order_date, order_count, 
-- ==================================================
SELECT 
		 order_date,
		 order_count,
		 daily_amount
FROM v_daily_sales
WHERE order_count >=2
ORDER BY daily_amount DESC;

-- ==================================================
-- 第8题
-- 创建或替换视图 v_category_avg_price，保存每个商品分类的平均价格。
-- 显示字段：category, category_avg_price
-- ==================================================
CREATE OR REPLACE VIEW v_category_avg_price AS
SELECT 
      category, 
			avg(price) AS category_avg_price
FROM products
GROUP BY category;

-- ==================================================
-- 第9题
-- 使用视图 v_category_avg_price 关联 products 表，查询价格高于本分类平均价格的商品。
-- 显示字段：product_id, product_name, category, price, category_avg_price
-- ==================================================
SELECT 
      p.product_id,
			p.product_name,
			vcap.category,
			p.price,
			vcap.category_avg_price
FROM v_category_avg_price AS vcap
INNER JOIN products AS p 
ON vcap.category = p.category
WHERE p.price > vcap.category_avg_price
ORDER BY vcap.category_avg_price DESC;

-- ==================================================
-- 第10题
-- 创建或替换视图 v_order_details，保存订单编号、用户编号、用户姓名、城市、订单日期、支付方式和实付金额。
-- 显示字段：order_id, user_id, user_name, city, order_date, payment_method, actual_amount
-- ==================================================
CREATE OR REPLACE VIEW v_order_detail AS
SELECT
      o.order_id, 
			u.user_id, 
			u.user_name, 
			u.city, 
			o.order_date,
			o.payment_method, 
			quantity * unit_price - discount_amount AS actual_amount
FROM orders AS o
INNER JOIN users AS u
ON o.user_id = u.user_id;
-- ==================================================
-- 第11题
-- 查询视图 v_order_details，筛选城市为“北京”的订单，并按订单日期从早到晚排序。
-- 显示字段：order_id, user_name, city, order_date, actual_amount
-- ==================================================
SELECT DISTINCT
    city
FROM users;
SELECT
      order_id, 
			user_name, 
			city, 
			order_date, 
			actual_amount
FROM v_order_detail
WHERE city = 'Beijing'
ORDER BY order_date ASC;

-- ==================================================
-- 第12题
-- 删除视图 v_user_order_counts。删除时即使该视图不存在，也不能报错。
-- ==================================================
DROP VIEW IF EXISTS v_user_order_counts;
