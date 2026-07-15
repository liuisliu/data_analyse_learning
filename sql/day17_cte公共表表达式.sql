-- ==================================================
-- 第1题
-- 使用 CTE 先统计每个用户的订单数量，再查询用户编号和订单数量。
-- 显示字段：user_id, order_count
-- ==================================================
WITH cte_order_count AS (
SELECT user_id,
       count(*) AS order_count
FROM orders
GROUP BY user_id
)
SELECT user_id,
       order_count
FROM cte_order_count;
-- ==================================================
-- 第2题
-- 使用 CTE 先计算每个用户的总实付金额，再查询总实付金额大于等于 1000 的用户。
-- 显示字段：user_id, total_amount
-- ==================================================
WITH cte_total_amount AS(
SELECT user_id,
       SUM(unit_price * quantity - discount_amount) AS total_amount
FROM orders
GROUP BY user_id
)
SELECT user_id,
       total_amount
FROM cte_total_amount
WHERE total_amount >= 1000;
-- ==================================================
-- 第3题
-- 使用 CTE 计算每个用户的总实付金额，并关联 users 表显示用户姓名和城市。
-- 只显示有订单的用户。
-- 显示字段：user_id, user_name, city, total_amount
-- ==================================================
WITH cte_total_amount AS(
SELECT user_id,
       SUM(unit_price * quantity - discount_amount) AS total_amount
FROM orders
GROUP BY user_id
)
SELECT cta.user_id, 
       u.user_name, 
       u.city, 
       cta.total_amount
FROM users AS u
INNER JOIN cte_total_amount AS cta
ON u.user_id = cta.user_id;

-- ==================================================
-- 第4题
-- 使用 CTE 计算每个用户的订单数量，并关联 users 表。
-- 要保留没有订单的用户，没有订单时订单数量显示为 0。
-- 显示字段：user_id, user_name, city, order_count
-- ==================================================
WITH cte_order_count AS (
SELECT user_id,
       count(*) AS order_count
FROM orders
GROUP BY user_id
)
SELECT coc.user_id, 
       u.user_name, 
       u.city, 
       coc.order_count
FROM users AS u
LEFT JOIN cte_order_count AS coc
ON u.user_id = coc.user_id;
			 

-- ==================================================
-- 第5题
-- 使用 CTE 先计算每个商品的销售数量和销售实付金额。
-- 再关联 products 表显示商品名称和商品分类。
-- 显示字段：product_id, product_name, category, sales_quantity, sales_amount
-- ==================================================
with cte_product AS (
SELECT product_id,
       sum(quantity) AS sales_quantity,
			 sum(quantity * unit_price - discount_amount) AS sales_amount
FROM orders
GROUP BY product_id
)
SELECT cp.product_id, 
       p.product_name, 
       p.category, 
       cp.sales_quantity, 
       cp.sales_amount
FROM products AS p
INNER JOIN cte_product AS cp
ON p.product_id = cp.product_id; 
-- ==================================================
-- 第6题
-- 使用 CTE 给每个用户的订单按实付金额从高到低编号。
-- 查询每个用户消费金额最高的前 2 笔订单。
-- 显示字段：order_id, user_id, order_date, actual_amount, amount_rank
-- ==================================================
WITH  cte_amount_rank AS (
SELECT
		 order_id, 
     user_id,
     order_date, 
     quantity * unit_price - discount_amount AS actual_amount, 
     ROW_NUMBER() over(
		     PARTITION by user_id
				 ORDER BY quantity * unit_price - discount_amount DESC   
				 ) AS amount_rank
 FROM orders
 ) 
 SELECT 
       order_id, 
			 user_id, 
			 order_date, 
			 actual_amount, 
			 amount_rank
FROM cte_amount_rank
WHERE amount_rank <= 2;

-- ==================================================
-- 第7题
-- 使用 CTE 计算每个分类的平均商品价格。
-- 再查询价格高于本分类平均价格的商品。
-- 显示字段：product_id, product_name, category, price, category_avg_price
-- ==================================================
WITH cte_price AS (
SELECT 
      product_id, 
			product_name, 
			category, 
			price,
			AVG(price) over(
			  PARTITION by category 
				) AS category_avg_price
FROM products
)
SELECT 
     product_id, 
		 product_name, 
		 category, 
		 price, 
		 category_avg_price
FROM cte_price
WHERE price > category_avg_price;

 


-- ==================================================
-- 第8题
-- 使用两个 CTE：第一个计算每个用户的总实付金额，第二个按总实付金额从高到低排名。
-- 查询总实付金额排名前 3 的用户。
-- 显示字段：user_id, total_amount, total_amount_rank
-- ==================================================
WITH cte_total_amount AS (
SELECT   
     user_id,
		 sum(quantity * unit_price - discount_amount) AS  total_amount
FROM orders
GROUP BY user_id
),
cte_total_amount_rank AS (
SELECT 
      user_id,
			total_amount,
			ROW_NUMBER() over(
				ORDER BY total_amount DESC
				) AS total_amount_rank
FROM cte_total_amount
)
SELECT 
      user_id, 
			total_amount, 
			total_amount_rank
FROM 	cte_total_amount_rank
WHERE 	total_amount_rank <= 3;	


-- ==================================================
-- 第9题
-- 使用 CTE 计算每个城市中用户的平均年龄。
-- 查询年龄高于所在城市平均年龄的用户。
-- 显示字段：user_id, user_name, city, age, city_avg_age
-- ==================================================
WITH cte_age AS (
SELECT 
      user_id, 
			user_name, 
			city, 
			age,
			ROUND(avg(age) over (
			    PARTITION by city
					) ,2 )
					AS city_avg_age
FROM users
)
SELECT 
      user_id, 
			user_name, 
			city, 
			age,
			city_avg_age
FROM  cte_age
WHERE age > city_avg_age;

-- ==================================================
-- 第10题
-- 使用 CTE 计算每个用户按订单日期累计的实付金额。
-- 查询累计实付金额大于 1000 的订单明细。
-- 显示字段：order_id, user_id, order_date, actual_amount, running_total_amount
-- ==================================================
 WITH cte_running_total_amount AS (
SELECT 
      order_id, 
			user_id, 
			order_date,
      quantity * unit_price - discount_amount AS actual_amount,
			sum(quantity * unit_price - discount_amount) over(
			  PARTITION by user_id
				ORDER BY  order_date 
				) AS running_total_amount
FROM orders
)
SELECT 
      order_id, 
			user_id, 
			order_date,
			actual_amount,
			running_total_amount
FROM cte_running_total_amount
WHERE running_total_amount > 1000;
			
-- ==================================================
-- 第11题
-- 使用 CTE 计算每个支付方式的订单数量和平均实付金额。
-- 查询订单数量不少于 2 的支付方式。
-- 显示字段：payment_method, order_count, payment_avg_amount
-- ==================================================
WITH cte_payment_method AS (
SELECT payment_method,
       count(*) AS order_count,
			 avg(quantity * unit_price - discount_amount) AS payment_avg_amount
FROM orders 
GROUP BY payment_method
)
SELECT 
      payment_method, 
			order_count, 
			payment_avg_amount
FROM cte_payment_method
WHERE order_count >= 2;

-- ==================================================
-- 第12题
-- 使用 CTE 计算每个用户的总实付金额，并给用户按总实付金额分为高、中、低三个层级。
-- 高：总实付金额大于 1000；中：总实付金额大于 500 且不大于 1000；低：总实付金额不大于 500。
-- 显示字段：user_id, total_amount, spend_level
-- ==================================================
WITH cte_total_amount AS (
SELECT 
      user_id,
			sum(quantity * unit_price - discount_amount)  AS  total_amount
FROM orders
GROUP BY  user_id
)
SELECT 
      user_id,
			total_amount,
			CASE   
	       WHEN total_amount > 1000 THEN  '高'
	       WHEN total_amount > 500 THEN  '中'	
	       ELSE  '低'
	       END AS 	spend_level
 FROM cte_total_amount;


			  







