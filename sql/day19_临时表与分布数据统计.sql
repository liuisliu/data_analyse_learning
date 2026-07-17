-- ==================================================
-- 第1题
-- 创建临时表 temp_user_order_counts，保存每个用户的订单数量。
-- 显示字段：user_id, order_count
-- ==================================================
CREATE TEMPORARY TABLE temp_user_order_counts AS 
SELECT 
      user_id, 
			count(*) AS order_count
FROM orders 
GROUP BY  user_id;

-- ==================================================
-- 第2题
-- 查询临时表 temp_user_order_counts，筛选订单数量不少于 2 的用户。
-- 显示字段：user_id, order_count
-- ==================================================
SELECT 
      user_id,
			order_count
FROM temp_user_order_counts
WHERE order_count >= 2;
-- ==================================================
-- 第3题
-- 删除临时表 temp_user_order_counts。删除时即使该表不存在，也不能报错。
-- ==================================================
DROP TEMPORARY TABLE IF EXISTS temp_user_order_counts;

-- ==================================================
-- 第4题
-- 创建临时表 temp_user_totals，保存每个用户的总实付金额。
-- 显示字段：user_id, total_amount
-- ==================================================
CREATE TEMPORARY TABLE temp_user_totals AS
SELECT
      user_id,
			SUM(quantity * unit_price - discount_amount) AS total_amount
FROM  orders
GROUP BY  user_id;

-- ==================================================
-- 第5题
-- 查询临时表 temp_user_totals，按总实付金额从高到低显示前 3 名用户。
-- 显示字段：user_id, total_amount
-- ==================================================
SELECT
      user_id, 
			total_amount
FROM temp_user_totals
ORDER BY total_amount DESC
LIMIT 3 ;

-- ==================================================
-- 第6题
-- 使用临时表 temp_user_totals 关联 users 表，查询用户编号、姓名、城市和总实付金额。
-- 只显示有订单的用户。
-- 显示字段：user_id, user_name, city, total_amount
-- ==================================================
SELECT
      tut.user_id,
			u.user_name,
			u.city,
			tut.total_amount
FROM temp_user_totals  AS tut
INNER JOIN users AS u
ON tut.user_id = u.user_id
ORDER BY tut.total_amount DESC;
      

-- ==================================================
-- 第7题
-- 创建临时表 temp_daily_sales，保存每个订单日期的订单数量和总实付金额。
-- 显示字段：order_date, order_count, daily_amount
-- ==================================================
CREATE TEMPORARY TABLE temp_daily_sales AS
SELECT
      order_date,
			count(*) AS order_count,
			SUM(quantity * unit_price - discount_amount) AS daily_amount
FROM orders
GROUP BY  order_date;

-- ==================================================
-- 第8题
-- 查询临时表 temp_daily_sales，筛选订单数量大于等于 2 的日期。
-- 显示字段：order_date, order_count, daily_amount
-- ==================================================
SELECT 
      order_date,
			order_count,
			daily_amount
FROM temp_daily_sales
WHERE order_count >=2;

-- ==================================================
-- 第9题
-- 为临时表 temp_daily_sales 的 order_date 字段创建普通索引。
-- 索引名：idx_temp_daily_sales_date
-- ==================================================
ALTER TABLE  temp_daily_sales
ADD INDEX idx_temp_daily_sales_date (order_date);

-- ==================================================
-- 第10题
-- 创建临时表 temp_category_avg_price，保存每个商品分类的平均价格。
-- 显示字段： category_avg_price
-- ==================================================
DROP TEMPORARY TABLE IF EXISTS temp_category_avg_price;
CREATE TEMPORARY TABLE temp_category_avg_price AS
SELECT
      category,
		  avg(price) AS category_avg_price
FROM products
GROUP BY category;


-- ==================================================
-- 第11题
-- 使用临时表 temp_category_avg_price 关联 products 表，查询价格高于本分类平均价格的商品。
-- 显示字段：product_id, product_name, category, price, category_avg_price
-- ==================================================
SELECT
      p.product_id,
			p.product_name,
			tcap.category,
			p.price,
			tcap.category_avg_price
FROM temp_category_avg_price AS tcap
INNER JOIN products AS p 
ON tcap.category = p.category
WHERE p.price > tcap.category_avg_price;

-- ==================================================
-- 第12题
-- 创建临时表 temp_payment_summary，保存每种支付方式的订单数量、平均实付金额和总实付金额。
-- 再查询订单数量不少于 2 的支付方式，并按总实付金额从高到低排序。
-- 显示字段：payment_method, order_count, payment_avg_amount, payment_total_amount
-- ==================================================
CREATE TEMPORARY TABLE temp_payment_summary AS
SELECT 
      payment_method,
      count(*) AS order_count, 
			ROUND(AVG(quantity * unit_price - discount_amount),2) AS payment_avg_amount,
			ROUND(SUM(quantity * unit_price - discount_amount) ,2)AS payment_total_amount
FROM orders
GROUP BY payment_method;

SELECT
      payment_method,
			order_count,
			payment_avg_amount,
			payment_total_amount
FROM temp_payment_summary
WHERE order_count >= 2 
ORDER BY payment_total_amount DESC