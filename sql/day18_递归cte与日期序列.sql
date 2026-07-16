-- ==================================================
-- 第1题
-- 使用递归 CTE 生成 1 到 10 的整数序列。
-- 显示字段：n
-- ==================================================
WITH recursive  numbers AS (
SELECT  
  1 AS n
  UNION ALL
SELECT 
  n + 1
FROM  numbers
WHERE n < 10
)
SELECT 
  n
FROM numbers;

-- ==================================================
-- 第2题
-- 使用递归 CTE 生成 5 到 15 的整数序列。
-- 显示字段：n
-- ==================================================
WITH recursive number AS (
SELECT 
   5 AS n 
UNION ALL
SELECT 
   n + 1
FROM number
WHERE n < 15
)
SELECT 
 n
FROM  number;

-- ==================================================
-- 第3题
-- 使用递归 CTE 生成 2026-01-01 到 2026-01-07 的连续日期。
-- 显示字段：report_date
-- ==================================================
WITH recursive round_date AS (
SELECT 
      DATE('2026-01-01') AS report_date
union all
SELECT 
      report_date + INTERVAL 1 DAY 
FROM round_date
WHERE report_date < DATE('2026-01-07')
)
SELECT 
     report_date
FROM round_date
ORDER BY report_date;

-- ==================================================
-- 第4题
-- 使用普通 CTE 找出 orders 表最早和最晚的订单日期，再使用递归 CTE 生成这两个日期之间的完整日期序列。
-- 显示字段：report_date
-- ==================================================





WITH recursive date_bounds AS(
SELECT 
      min(order_date) AS min_date,
			max(order_date) AS max_date
FROM orders
),
date_list AS (
SELECT 
      min_date AS report_date
FROM date_bounds
UNION ALL
SELECT 
      report_date + INTERVAL 1 DAY  
FROM date_list as dl
INNER JOIN  date_bounds AS db
ON dl.report_date < db.max_date
)
SELECT 
      report_date
FROM date_list;
-- ==================================================
-- 第5题
-- 使用递归 CTE 生成 orders 表最早订单日期之后连续 7 天的日期。
-- 显示字段：report_date
-- ==================================================





WITH recursive min_date AS (
SELECT
      min(order_date) AS min_order_date
FROM orders
),
date_round AS (
SELECT 
       min_order_date AS report_date
FROM min_date

UNION ALL

SELECT 
      report_date + INTERVAL 1 DAY
FROM date_round AS dr
INNER JOIN min_date AS md 
ON dr.report_date < md.min_order_date + INTERVAL 7 DAY
)
SELECT 
      report_date
FROM date_round;
-- ==================================================
-- 第6题
-- 使用递归 CTE 生成 orders 表最早和最晚订单日期之间的完整日期序列。
-- 再统计每一天的订单数量；没有订单的日期订单数量显示为 0。
-- 显示字段：report_date, order_count
-- ==================================================
WITH recursive date_min_max AS (
SELECT 
      min(order_date) AS min_date,
			max(order_date) AS max_date
FROM orders
),
date_series AS (
SELECT 
      min_date AS report_date
FROM  date_min_max
UNION ALL
SELECT 
      ds.report_date + INTERVAL 1 DAY
FROM  date_series AS ds
INNER JOIN date_min_max AS dmm
ON ds.report_date < dmm.max_date
),
sum_order AS (
SELECT 
      order_date,
      count(*) AS order_count 
FROM orders 
GROUP BY order_date
)
SELECT 
      ds.report_date,
			COALESCE(so.order_count , 0) AS order_count 
FROM  date_series AS ds    
LEFT JOIN sum_order AS so
ON ds.report_date = so.order_date;

-- ==================================================
-- 第7题
-- 使用递归 CTE 生成完整日期序列，再统计每一天的实付金额。
-- 没有订单的日期实付金额显示为 0。
-- 显示字段：report_date, daily_amount
-- ==================================================
WITH recursive date_min_max AS (
SELECT 
      min(order_date) AS min_date,
			max(order_date) AS max_date
FROM orders
),
date_series AS (
SELECT 
      min_date AS report_date
FROM  date_min_max
UNION ALL
SELECT 
      ds.report_date + INTERVAL 1 DAY
FROM  date_series AS ds
INNER JOIN date_min_max AS dmm
ON ds.report_date < dmm.max_date
),
sum_amount AS (
SELECT 
      order_date,
			sum(quantity * unit_price - discount_amount) AS daily_amount
FROM orders
GROUP BY order_date
)
SELECT 
      ds.report_date,
			COALESCE(sa.daily_amount,0) AS daily_amount
FROM date_series AS ds
LEFT JOIN sum_amount AS sa
ON ds.report_date = sa.order_date;
			

-- ==================================================
-- 第8题
-- 在第 7 题完整日期和每日实付金额的基础上，计算按日期累计的实付金额。
-- 显示字段：report_date, daily_amount, running_daily_amount
-- ==================================================
WITH recursive date_min_max AS (
SELECT 
      min(order_date) AS min_date,
			max(order_date) AS max_date
FROM orders
),
date_series AS (
SELECT 
      min_date AS report_date
FROM  date_min_max
UNION ALL
SELECT 
      ds.report_date + INTERVAL 1 DAY
FROM  date_series AS ds
INNER JOIN date_min_max AS dmm
ON ds.report_date < dmm.max_date
),
sum_amount AS (
SELECT 
      order_date,
			sum(quantity * unit_price - discount_amount) AS daily_amount
FROM orders
GROUP BY order_date
),
cte_daily_amount AS (
SELECT 
      ds.report_date,
			COALESCE(sa.daily_amount,0) AS daily_amount
FROM date_series AS ds
LEFT JOIN sum_amount AS sa
ON ds.report_date = sa.order_date
)
SELECT 
      report_date,
			daily_amount,
			sum(daily_amount) over(
				ORDER BY report_date
				) AS running_daily_amount
FROM   cte_daily_amount;  

-- ==================================================
-- 第9题
-- 使用递归 CTE 生成 1 到 12 的月份序列。
-- 显示字段：month_number
-- ==================================================
with recursive cte_month_number AS(
SELECT 
      DATE('2026-01-01') AS month_number
UNION ALL
SELECT 
      month_number + INTERVAL 1 MONTH
FROM cte_month_number
WHERE month_number < DATE('2026-12-01')
)
SELECT  
		  month_number
FROM cte_month_number;  


正确写法：
WITH RECURSIVE cte_month_number AS (
    SELECT
        1 AS month_number

    UNION ALL

    SELECT
        month_number + 1
    FROM cte_month_number
    WHERE month_number < 12
)
SELECT
    month_number
FROM cte_month_number;

-- ==================================================
-- 第10题
-- 使用递归 CTE 生成 2、4、6、8、10 这 5 个偶数。
-- 显示字段：even_number
-- ==================================================
WITH recursive  cte_even_number AS(
SELECT 
      2 AS even_number
UNION ALL
SELECT 
      even_number + 2
FROM  cte_even_number
WHERE even_number < 10
)
SELECT even_number
FROM  cte_even_number;

-- ==================================================
-- 第11题
-- 使用递归 CTE 生成 1 到 20 的整数序列。
-- 只查询其中能够被 3 整除的数字。
-- 显示字段：n
-- ==================================================
WITH recursive number AS(
SELECT 
      1 AS n 
UNION ALL
SELECT 
      n + 1 
FROM number
WHERE n < 20
)
SELECT 
     n  
FROM number
WHERE n % 3 = 0 ;

-- ==================================================
-- 第12题
-- 使用递归 CTE 生成 orders 表最早和最晚订单日期之间的完整日期序列。
-- 统计每天的订单数量和实付金额，并计算每天截至当前日期的累计实付金额。
-- 没有订单的日期，订单数量和实付金额都显示为 0。
-- 显示字段：report_date, order_count, daily_amount, running_daily_amount
-- ==================================================
with  recursive min_max_date AS(
SELECT 
      min(order_date) AS min_date,
			max(order_date) AS max_date
FROM orders
),
date_seris AS (
SELECT 
      min_date AS report_date
FROM min_max_date

UNION ALL

SELECT 
		  ds.report_date + INTERVAL 1 DAY
FROM date_seris AS ds 
INNER JOIN  min_max_date AS mmd
ON ds.report_date <  mmd.max_date
),
cte_amount AS (
SELECT 
      order_date,
			count(*) AS order_count,
			sum(quantity * unit_price - discount_amount) AS daily_amount,
			sum(quantity * unit_price - discount_amount) over(
			    PARTITION by order_date
					order by order_date
					) AS running_daily_amount
FROM orders
GROUP BY order_date
)

			
正确写法：
WITH RECURSIVE date_bounds AS (
    SELECT
        MIN(order_date) AS min_date,
        MAX(order_date) AS max_date
    FROM orders
),
date_series AS (
    SELECT
        min_date AS report_date
    FROM date_bounds

    UNION ALL

    SELECT
        ds.report_date + INTERVAL 1 DAY
    FROM date_series AS ds
    INNER JOIN date_bounds AS db
        ON ds.report_date < db.max_date
),
daily_sales AS (
    SELECT
        order_date,
        COUNT(*) AS order_count,
        SUM(quantity * unit_price - discount_amount) AS daily_amount
    FROM orders
    GROUP BY order_date
),
calendar_sales AS (
    SELECT
        ds.report_date,
        COALESCE(dy.order_count, 0) AS order_count,
        COALESCE(dy.daily_amount, 0) AS daily_amount
    FROM date_series AS ds
    LEFT JOIN daily_sales AS dy
        ON ds.report_date = dy.order_date
)
SELECT
    report_date,
    order_count,
    daily_amount,
    SUM(daily_amount) OVER (
        ORDER BY report_date
    ) AS running_daily_amount
FROM calendar_sales
ORDER BY report_date;


 





