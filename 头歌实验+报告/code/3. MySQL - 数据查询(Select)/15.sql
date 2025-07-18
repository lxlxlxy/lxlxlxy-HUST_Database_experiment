-- 15) 查询资产表中客户编号，客户基金投资总收益,基金投资总收益的排名(从高到低排名)。
--     总收益相同时名次亦相同(即并列名次)。总收益命名为total_revenue, 名次命名为rank。
--     第一条SQL语句实现全局名次不连续的排名，
--     第二条SQL语句实现全局名次连续的排名。

-- (1) 基金总收益排名(名次不连续)
SELECT pro_c_id,total_revenue,trank AS 'rank'
FROM(
    SELECT pro_c_id,total_revenue,
        @rankcount := @rankcount + 1,   #记录当前行号
        IF(@current_revenue = total_revenue, @rank, @rank := @rankcount) AS trank,#如果当前收益等于上一行收益则行号不变，否则行号等于当前行号
        @current_revenue := total_revenue   #当前收益赋给上一行收益
    FROM(
        SELECT pro_c_id,SUM(pro_income) AS total_revenue 
        FROM property
        WHERE pro_type = 3
        GROUP BY pro_c_id
        ORDER BY total_revenue DESC, pro_c_id
    ) AS i,               #计算投资总收益作为表i
    (
        SELECT @rank := 0, @current_revenue := 0, @rankcount := 0
    ) AS v       #初始化用户变量，只执行一次，两个表做笛卡尔积
) AS t; 


-- (2) 基金总收益排名(名次连续)
SELECT pro_c_id,total_revenue,trank AS 'rank'
FROM(
    SELECT pro_c_id,total_revenue,
        IF(@current_revenue = total_revenue, @rank, @rank := @rank + 1) AS trank,  #不相同则排名+1
        @current_revenue := total_revenue
    FROM(
        SELECT pro_c_id,SUM(pro_income) AS total_revenue 
        FROM property
        WHERE pro_type = 3
        GROUP BY pro_c_id
        ORDER BY total_revenue DESC, pro_c_id
    ) AS i,
    (
        SELECT @rank := 0, @current_revenue := 0
    ) AS v  #初始化，没有行号记录了
) AS t;



/*  end  of  your code  */