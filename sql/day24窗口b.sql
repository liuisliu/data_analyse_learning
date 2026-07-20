-- 第5题（窗口 B）
-- 在另一个窗口开始事务，将 order_id 等于 1 的订单优惠金额增加 1。
-- 观察是否等待窗口 A 释放锁。
-- ==================================================

START TRANSACTION;

UPDATE orders
SET discount_amount = discount_amount + 1
WHERE order_id = 'O0001';


SELECT
      order_id, 
			discount_amount
FROM orders
WHERE order_id = 'O0001';

ROLLBACK;