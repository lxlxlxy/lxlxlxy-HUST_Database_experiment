    -- 4) 	查找相似的理财产品
#  相似度 = 同时持有产品14和其他理财产品的客户数量
#  产品14的核心客户群（持有A数量最多前三名）购买其他理财产品的总人数
#  相似的理财产品 = 相似度最高的3款理财产品

#查找产品14的相似理财产品编号（不包含14自身）（pro_pif_id）、该编号的理财产品的客购买客户总人数（cc）以及该理财产品对于14 号理财产品的相似度排名值（prank）

--   请用一条SQL语句实现该查询：
SELECT pro_pif_id, COUNT(*) as cc, dense_rank() over(order by COUNT(*) DESC) AS prank  #按理财产品被核心客户购买的次数(COUNT(*))分组，降序分配排名
FROM property
WHERE 
    pro_type = 1 AND
    pro_pif_id in
    (SELECT DISTINCT pro_pif_id    #子查询1：找出除14外，被特定客户群购买过的所有理财产品
    FROM property 
    WHERE 
        pro_type = 1 AND
        pro_pif_id <> 14 AND
        pro_c_id in
        (SELECT pro_c_id          #子查询2：找出购买产品14数量最多的前3名客户
        FROM 
            (SELECT pro_c_id, dense_rank() over(order by pro_quantity) AS rk  
            FROM property
            WHERE pro_type = 1 AND
                pro_pif_id = 14) fin_rk       #按排名生成每个客户购买产品14的数量的表
        WHERE fin_rk.rk <= 3))
GROUP BY pro_pif_id
ORDER BY cc DESC, pro_pif_id ASC;






/*  end  of  your code  */