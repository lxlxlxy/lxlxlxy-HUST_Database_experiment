-- 5) 查询任意两个客户的相同理财产品数
--   请用一条SQL语句实现该查询：
# 第一列和第二列输出客户编号(pro_c_id,pro_c_id)，第三列输出他们持有的相同理财产品数(total_count)，按照第一列的客户编号的升序排列
SELECT pid_1 AS pro_c_id, pid_2 AS pro_c_id, COUNT(*) AS total_count
FROM      #通过自连接找出持有相同理财产品的不同客户对
    (SELECT p1.pro_c_id AS pid_1, p2.pro_c_id AS pid_2, p1.pro_pif_id
    FROM property p1, property p2
    WHERE p1.pro_type = 1 AND
        p2.pro_type = 1 AND
        p1.pro_c_id <> p2.pro_c_id AND   #排除客户与自身的比较
        p1.pro_pif_id = p2.pro_pif_id) same_fin  #确保比较的是同一产品
GROUP BY pid_1,pid_2
HAVING COUNT(*) >= 2
ORDER BY pid_1;






/*  end  of  your code  */