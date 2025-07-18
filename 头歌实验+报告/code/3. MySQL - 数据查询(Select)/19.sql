-- 19) 以日历表格式列出2022年2月每周每日基金购买总金额，输出格式如下：
-- week_of_trading Monday Tuesday Wednesday Thursday Friday
--               1
--               2    
--               3
--               4
--   请用一条SQL语句实现该查询：
SELECT week_of_trading, SUM(IF(days=0,amount,NULL)) AS Monday, SUM(IF(days=1,amount,NULL)) AS Tuesday, SUM(IF(days=2,amount,NULL)) AS Wednesday, SUM(IF(days=3,amount,NULL)) AS Thursday, SUM(IF(days=4,amount,NULL)) AS Friday
FROM 
    (SELECT week(pro_purchase_time)-5 AS week_of_trading,    #返回周数（第一周次在当年是第六周）
    SUM(f_amount*pro_quantity) AS amount,    #返回基金购买总金额
    weekday(pro_purchase_time) AS days   #返回星期几
    FROM fund, property
    WHERE f_id = pro_pif_id AND
    pro_type = 3 AND
    pro_purchase_time >= "2022-2-7" AND
    pro_purchase_time <= "2022-2-28"   #2月的时间范围
    GROUP BY pro_purchase_time) AS a
GROUP BY week_of_trading
ORDER BY week_of_trading ASC;






/*  end  of  your code  */