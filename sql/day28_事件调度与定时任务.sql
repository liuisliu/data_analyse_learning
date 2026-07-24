-- ==================================================
-- 第1题
-- 查询当前服务器的 event_scheduler 设置。
-- 观察字段：Variable_name, Value
-- ==================================================
SHOW EVENTS;

SHOW VARIABLES LIKE 'event_scheduler';

-- ==================================================
-- 第2题
-- 查看当前数据库中已有的事件。
-- 观察字段：Db, Name, Status, Type, Execute at, Interval value, Interval field
-- ==================================================
SHOW EVENTS;

-- ==================================================
-- 第3题
-- 删除表 event_practice_log。即使该表不存在，也不能报错。
-- 再创建该表，用于记录事件执行日志。
-- 显示字段：log_id, message, created_at
-- ==================================================
DROP TABLE IF EXISTS event_practice_log;

CREATE TABLE event_practice_log(
log_id BIGINT PRIMARY KEY  AUTO_INCREMENT,
message VARCHAR(255),
created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP 
);


-- ==================================================
-- 第4题
-- 删除事件 e_day28_once。即使该事件不存在，也不能报错。
-- 再创建一次性事件 e_day28_once，在当前时间一天后向 event_practice_log 写入一条日志。
-- ==================================================
DROP EVENT  IF  EXISTS e_day28_once;

CREATE EVENT e_day28_once
ON SCHEDULE  AT CURRENT_TIMESTAMP + INTERVAL 1 DAY
DO
INSERT INTO event_practice_log (message)
VALUES('evnent test');
-- ==================================================
-- 第5题
-- 查看事件 e_day28_once 的完整创建语句。
-- ==================================================
SHOW CREATE EVENT e_day28_once;

-- ==================================================
-- 第6题
-- 将事件 e_day28_once 的执行时间改为当前时间两天后。
-- ==================================================
ALTER event e_day28_once 
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 2 DAY;

-- ==================================================
-- 第7题
-- 禁用事件 e_day28_once。
-- ==================================================
SHOW events;
ALTER EVENT e_day28_once DISABLE;

-- ==================================================
-- 第8题
-- 删除事件 e_day28_daily。即使该事件不存在，也不能报错。
-- 再创建重复事件 e_day28_daily，每天向 event_practice_log 写入一条日志。
-- 第一次执行时间设置为当前时间一天后。
-- ==================================================
DROP EVENT IF EXISTS e_day28_daily;

CREATE EVENT  e_day28_daily
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP + INTERVAL 1 DAY
DO
INSERT INTO event_practice_log(message)
VALUES ('event_test2');
-- ==================================================
-- 第9题
-- 查看当前数据库中的事件，确认 e_day28_once 和 e_day28_daily 的状态和计划信息。
-- 观察字段：Name, Status, Type, Execute at, Interval value, Interval field
-- ==================================================
SHOW EVENTS;

-- ==================================================
-- 第10题
-- 使用 SQL 注释说明事件调度器、触发器和存储过程分别在什么情况下执行。
-- ==================================================
--事件调度器 是按照时间的规则来进行自动执行
--触发器是一段自动执行的sql语句，当出现update delete 等数据更新的sql语句中，自动执行
--存储过程是要用户手动调用，存储过程是一段可以重复执行的sql语句
-- ==================================================
-- 第11题
-- 使用 SQL 注释说明为什么不能依靠当前 Navicat 窗口的 ROLLBACK 撤销已经由定时事件执行的修改。
-- ==================================================
-- 当前 Navicat 窗口的 ROLLBACK 只能回滚当前数据库连接中，
-- 当前事务尚未提交的修改。
-- 定时事件由 MySQL Event Scheduler 在服务器后台的独立连接中执行，
-- 不属于当前 Navicat 窗口的事务。
-- 因此，当前窗口的 ROLLBACK 不能撤销已经由定时事件执行的修改。

-- ==================================================
-- 第12题
-- 删除事件 e_day28_once 和 e_day28_daily。
-- 删除表 event_practice_log。
-- 删除时即使对象不存在，也不能报错。
-- ==================================================

DROP EVENT IF EXISTS e_day28_once;

DROP EVENT IF EXISTS  e_day28_daily;

DROP TABLE IF EXISTS  event_practice_log;